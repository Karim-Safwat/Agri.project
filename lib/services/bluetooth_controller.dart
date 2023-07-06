import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  late String tempreture;
  late String humidity;
  late String motorState;
  @override
  void onInit() async {
    tempreture = 'not detected';
    humidity = 'not detected';
    motorState = 'not detected';
    await initiateConnection();
    super.onInit();
  }

  /**
   *   String macAddress_tablet = "0C:2F:B0:FE:ED:23";
  String macAddress_camera = "F4:63:1F:D0:03:4E";
  String macAddress_arduino_camera = "00:21:09:00:4F:8C";
  String macAddress_arduino_screen = "00:21:09:00:4D:35";
  
  * Moksha HC-05 mac : 00:22:05:00:2B:C9
  
   */

  static late BluetoothDevice arduniDevice;
  static late BluetoothConnection connection;
  String comingData = "";
  String HC_05Mac = "00:21:09:00:4F:8C";
  String connectionStatus = 'not connected';

  Future<void> initiateConnection() async {
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
      connectionStatus = 'connecting';
      update();
      await BluetoothConnection.toAddress(HC_05Mac).then(
        (value) async {
          connection = value;
          print('''\n\n\nHC-05 connected''');
          connectionStatus = 'connected';
          update();
          await startListeningToBluetoothStream();
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
      print('start listening to Bluetooth Module');
      connection.input!.listen((Uint8List data) {
        String comingMessage = utf8.decode(data);
        List<String> dataInList = comingMessage.split(',');
        tempreture = dataInList[0];
        humidity = dataInList[1];
        motorState = dataInList[2];
        update();
      });
    } catch (e) {
      print('Error While  listening to Bluetooth Module : \n $e');
      // Timer(
      //   Duration(seconds: 5),
      //   () async {
      //     print('Erro While  listening to Bluetooth Module');

      //     await startListeningToBluetoothStream();
      //   },
      // );
    }
  }

  Future<void> closeConnection() async {
    await connection.close();
  }
}
