
// filename: blecontroller.dart
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:math';

class BleController {
  final frb = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> c;
  late QualifiedCharacteristic tx;
  var status = 'connect to bluetooth'.obs;
  
int getRand(){
  final random = Random();
  return random.nextInt(100000);}

void sendData(val) async{
List<int> data=[0,0];
data[0] = val.toInt();
data[1] = getRand();
print(data[1]);
print(val.toInt());
await frb.writeCharacteristicWithoutResponse(tx, value: data);}  

  void connect() async {
    status.value = 'connecting...';
    c = frb.connectToDevice(id: "28:CD:C1:04:E8:51").listen((state) {
      if (state.connectionState == DeviceConnectionState.connected) {
        status.value = 'connected!';

        tx = QualifiedCharacteristic(
            serviceId:        Uuid.parse("6e400001-b5a3-f393-e0a9-e50e24dcca9e"),
            characteristicId: Uuid.parse("6e400002-b5a3-f393-e0a9-e50e24dcca9e"),
            deviceId: "28:CD:C1:04:E8:51");
}});}}
