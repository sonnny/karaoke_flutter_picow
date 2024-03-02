///////////////////////main.dart

//demo to control karaoke machine from android
//modified from https://github.com/pinkeshdarji/flutter_gridview
//getting error compiling solution on android/app/build.gradle
//   dependencies section
//link for solution -- https://dev.to/retyui/fix-react-native-android-builds-duplicate-class-kotlincollections-found-in-modules-jetified-kotlin-stdlib-180-2ca7

/*
astra mega sound karaoke codes
format: NEC infrared protocol
address 0x00 0xFF
listed below are data only

power 0x14

play/pause 0x46

delete 0x13

stop 0x4B

reserve 0x03

next 0x52

0 0x51 0xAE

1 0x08 0xF7

2 0x48 0xB7

3 0x49 0xB6

4 0x0F 0xF0

5 0x0A 0xF5

6 0x1E 0xE1

7 0x53 0xAC

8 0x55 0xAA

9 0x56 0xA9
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './blecontroller.dart';

final numberStyle = TextStyle(color: Colors.white,
fontSize: 24,fontWeight: FontWeight.bold);

final letterStyle = TextStyle(color: Colors.white,
fontSize: 16,fontWeight: FontWeight.bold);

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
@override Widget build(BuildContext context) {
return MaterialApp(debugShowCheckedModeBanner: false,
title: 'Flutter Demo',
theme: ThemeData(primarySwatch: Colors.teal, 
brightness: Brightness.dark),
home: GridCount(),);}}

///////////////////////////////////////
class GridCount extends StatelessWidget {@override
Widget build(BuildContext context) {
final BleController ble = Get.put(BleController());
return Scaffold(appBar: AppBar(title: Text('Karaoke')),
  body: Column(children: [
    
Spacer(flex: 3),
ElevatedButton(onPressed: ble.connect,
child: Obx(()=>Text('${ble.status.value}'))),
GridView.count(crossAxisCount: 3,crossAxisSpacing: 0,
  shrinkWrap: true,
  padding: EdgeInsets.only(left: 24, right: 24),
  children:[
//refactor on tap function, repetitous
DialKey(number: '#', letters: 'STP', onTap:(){ble.sendData(0x4B);}),
DialKey(number: '^', letters: 'NXT', onTap:(){ble.sendData(0x52);}),
DialKey(number: '@', letters: 'RES', onTap:(){ble.sendData(0x03);}),
DialKey(number: '1', letters: '',    onTap:(){ble.sendData(0x08);}),
DialKey(number: '2', letters: 'ABC', onTap:(){ble.sendData(0x48);}),
DialKey(number: '3', letters: 'DEF', onTap:(){ble.sendData(0x49);}),
DialKey(number: '4', letters: 'GHI', onTap:(){ble.sendData(0x0f);}),
DialKey(number: '5', letters: 'JKL', onTap:(){ble.sendData(0x0a);}),
DialKey(number: '6', letters: 'MNO', onTap:(){ble.sendData(0x1e);}),
DialKey(number: '7', letters: 'PQR', onTap:(){ble.sendData(0x53);}),
DialKey(number: '8', letters: 'TUV', onTap:(){ble.sendData(0x55);}),
DialKey(number: '9', letters: 'WXY', onTap:(){ble.sendData(0x56);}),
DialKey(number: '*', letters: 'PLAY',onTap:(){ble.sendData(0x46);}),
DialKey(number: '0', letters: '+',   onTap:(){ble.sendData(0x51);}),
DialKey(number: '#', letters: 'DEL', onTap:(){ble.sendData(0x13);})
]),
Spacer()]));}}

////////////////////////////////////////
class DialKey extends StatelessWidget {
final String? number;
final String? letters;
final Function()? onTap;

DialKey({this.number, this.letters, this.onTap});

@override Widget build(BuildContext context) {
return Center(child: Container(
  width: 80,height: 80,
  child: FloatingActionButton(
  onPressed: onTap,
  backgroundColor: Colors.grey.withOpacity(0.5),
  child: Column(mainAxisAlignment: MainAxisAlignment.center,
  children: 
  
[Text('$number',style: numberStyle),
Text('$letters',style: letterStyle)]))));}}
