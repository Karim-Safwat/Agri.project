import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:final_agriculture_project/components/components.dart';
import 'package:final_agriculture_project/layout/cubit/cubit.dart';
import 'package:final_agriculture_project/layout/cubit/states.dart';
import 'package:final_agriculture_project/services/bluetooth_controller.dart';
import 'package:final_agriculture_project/styles/bloc/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectStates>(
      listener: (context, state) {
        // if(state is ProjectAddCropState){
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //       const Add_Screen(),
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        var cubit = ProjectCubit.get(context);
        return GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (bl_controller) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Text(
                  cubit.Titles[cubit.CurrentIndex],
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await bl_controller.closeConnection();
                    },
                    icon: Icon(Icons.bluetooth_disabled),
                  ),
                  IconButton(
                    onPressed: () async {
                      await bl_controller.initiateConnection();
                    },
                    icon: Icon(Icons.bluetooth_audio_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      AppThemeModeCubit.get(context).changeAppThemeMode();
                    },
                    icon: const Icon(
                      Icons.brightness_4_outlined,
                    ),
                  ),
                ],
              ),
              body: cubit.Screens[cubit.CurrentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.CurrentIndex,
                onTap: (index) {
                  cubit.ChangeBottomNav(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.control_camera),
                    label: 'Control',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notes),
                    label: 'Notes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }
}
