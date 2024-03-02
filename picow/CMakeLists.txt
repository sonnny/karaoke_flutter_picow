# mkdir build
# cd build
# cmake ..
# make

# sudo openocd
#   -f interface/cmsis-dap.cfg
#   -f target/rp2040.cfg
#   -c "adapter speed 5000"
#   -c "program jeep.elf verify reset exit"

cmake_minimum_required(VERSION 3.12)
set(PICO_SDK_PATH "/home/sonny/pico/pico-sdk")
set(PICO_SDK_POST_LIST_DIRS "/home/sonny/pico/pico-extras")
set(PICO_BOARD "pico_w")

include("${PICO_SDK_PATH}/external/pico_sdk_import.cmake")
include("${PICO_SDK_POST_LIST_DIRS}/external/pico_extras_import.cmake")

project(karaoke_ir C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()

add_executable(karaoke_ir karaoke_ir.c ble.c nec_transmit.c)

pico_generate_pio_header(karaoke_ir ${CMAKE_CURRENT_LIST_DIR}/nec_carrier_burst.pio)
pico_generate_pio_header(karaoke_ir ${CMAKE_CURRENT_LIST_DIR}/nec_carrier_control.pio)

target_link_libraries(karaoke_ir
  pico_stdlib
  hardware_pio
  hardware_pwm
  hardware_gpio
  pico_btstack_ble
  pico_btstack_cyw43
  pico_btstack_classic
  pico_cyw43_arch_none
  pico_multicore)

target_include_directories(karaoke_ir PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    )
pico_btstack_make_gatt_header(karaoke_ir PRIVATE "${CMAKE_CURRENT_LIST_DIR}/mygatt.gatt")
  
pico_add_extra_outputs(karaoke_ir)
