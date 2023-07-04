import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothController{


  BluetoothController._privateConstructor();

  static final BluetoothController _instance = BluetoothController._privateConstructor();

  static BluetoothController get instance => _instance;
  static late BluetoothDevice arduniDevice;
  static late BluetoothConnection connection;
  String comingData = "";
  String HC_05Mac ="00:22:05:00:2B:C9";
  String connectionStatus='not connected';

  void initiateConnection() async {
    print('''\n\n\n start enabling Bluetooth ''');
    bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (isEnabled!) {
      await getAllBoundedDeviceThenStartConnection();
    } else {
      await FlutterBluetoothSerial.instance.requestEnable().then((value) async {
        if (value == true) {
          await getAllBoundedDeviceThenStartConnection();
        }
      });
    }
  }

  /**
   * After the connection has been Stablished ,
   * show all bonded device to get HC-05 Bluetooth module
   * to connect with ✅ .
   */
  Future<void> getAllBoundedDeviceThenStartConnection() async {
    print('''\n\n\n Getting All paired Bluetooth Devices''');
    // get all bonded devices on tablet .
    var bondedDevices =
    await FlutterBluetoothSerial.instance.getBondedDevices();
    for (int i = 0; i < bondedDevices.length; i++) {
      if (bondedDevices[i].address == HC_05Mac) {
        arduniDevice = bondedDevices[i];
        break;
      }
    }
    if (!arduniDevice.isConnected) {
      await connectTo_HC_05Module();
    }
  }

  Future<void> connectTo_HC_05Module() async {
    try {

      /**
       * to connect with bluetooth module .
       */
      print('''\n\n\n start Connecting to HC-05 ''');
      connectionStatus='connecting';
      connection =
      await BluetoothConnection.toAddress(HC_05Mac).then(
            (value) async {
              print('''\n\n\nHC-05 connected''');
          connectionStatus='connected';
          await startListeningToBluetoothStream();
          return value;
        },
      );
    } catch (e) {
      Timer(
        Duration(seconds: 2),
            () async {
          await connectTo_HC_05Module();
        },
      );
    }
  }

  Future<void> startListeningToBluetoothStream() async {
    try {
      connection.input!.listen((Uint8List data) {
      });
    } catch (e) {
      await startListeningToBluetoothStream();
    }
  }





}