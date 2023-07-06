import 'package:final_agriculture_project/services/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Control_Screen extends StatefulWidget {
  const Control_Screen({Key? key}) : super(key: key);

  @override
  State<Control_Screen> createState() => _Control_ScreenState();
}

class _Control_ScreenState extends State<Control_Screen> {
  var tempcontroller = TextEditingController();
  var moisturecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<BluetoothController>(builder: (bl_controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                        "Bluetooth Connection Status : ${bl_controller.connectionStatus}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Data from Sensor",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.sensors_sharp,
                          size: 35,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.real_estate_agent_outlined,
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "These are the real values...",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        "Connection Status : ${bl_controller.connectionStatus}")
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sunny,
                      color: Colors.amber,
                      size: 70,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${bl_controller.tempreture}",
                            style: TextStyle(fontSize: 19),
                          ),

                          // TextFormField(
                          //   decoration: InputDecoration(
                          //       label:Text("temperature",
                          //         style: TextStyle(
                          //             fontSize: 19
                          //         ),),
                          //       border: UnderlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       )
                          //   ),
                          //   keyboardType: TextInputType.number,
                          //   controller: tempcontroller,
                          // ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sunny_snowing,
                      color: Colors.blue[200],
                      size: 70,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${bl_controller.humidity}",
                            style: TextStyle(fontSize: 19),
                          ),
                          // TextFormField(
                          //   decoration: InputDecoration(
                          //       label:Text("moisture",
                          //       style: TextStyle(
                          //         fontSize: 19
                          //       ),
                          //       ),
                          //       border: UnderlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       )
                          //   ),
                          //   keyboardType: TextInputType.number,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text("Motor State : ${bl_controller.motorState}"),
                SizedBox(
                  height: 24,
                ),
                Switch(
                    //  thumbIcon:,
                    value: false,
                    onChanged: (bool) {}),
              ],
            ),
          );
        }),
      ),
    );
  }
}
