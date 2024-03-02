#include "pico/stdlib.h"
#include "pico/multicore.h"
#include "hardware/gpio.h"
#include "hardware/pio.h"
#include "ble.h"
#include "nec_transmit.h"

struct bt_type data;
uint8_t tx_address=0x00;
uint8_t old_data=0x00;
uint32_t tx_frame=0x00;
int tx_sm=0;

int main(){
  stdio_init_all();
  tx_sm=nec_tx_init(pio0,10);
  multicore_launch_core1(bt_main);
  sleep_ms(500);
  for(;;){
    sleep_ms(100);
    bt_get_latest(&data);
    if(data.data != old_data){
	  tx_frame=nec_encode_frame(tx_address,data.code);
      pio_sm_put(pio0,tx_sm,tx_frame);
      old_data = data.data;
}}return 0;}
