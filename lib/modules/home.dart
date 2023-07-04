import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:final_agriculture_project/components/components.dart';
import 'package:final_agriculture_project/components/constants.dart';
import 'package:final_agriculture_project/layout/cubit/cubit.dart';
import 'package:final_agriculture_project/layout/cubit/states.dart';
import 'package:final_agriculture_project/models/data_model.dart';
import 'package:final_agriculture_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Home_Screen extends StatelessWidget
{
  var ScaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();

  var namecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  var typecontroller=TextEditingController();
  var temperaturecontroller=TextEditingController();
  var moisturecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProjectCubit.get(context).SendData();
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (context,state){},
      builder: (context,state){
        //var usermodel=ProjectCubit.get(context).model;
      var Datamodel=ProjectCubit.get(context).datamodel;
      //uid=usermodel!.uid;
      namecontroller.text='${Datamodel?.CropName}';
      datecontroller.text='${Datamodel?.CropDate}';
      typecontroller.text='${Datamodel?.CropSeason}';
      temperaturecontroller.text='${Datamodel?.CropTemperature}';
      moisturecontroller.text='${Datamodel?.CropMoisture}';
        return  Scaffold(
          appBar: AppBar(title:
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  child: Text("Refresh",),
              onPressed: (){
                    ProjectCubit.get(context).SendData();
              },
              ),
              Icon(Icons.refresh),
            ],
            )
            ,),
          key: ScaffoldKey,
          body: ListView.separated(
            itemBuilder: (context,index)=>builditem(context,ProjectCubit.get(context).field[index]),
            separatorBuilder: (context,index)=>SizedBox(height: 0.0,),
            itemCount: ProjectCubit.get(context).field.length,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              if(ProjectCubit.get(context).isbottomsheetshown) {
                if(formKey.currentState!.validate()){
                  //هنا ممكن نعمل ال تخزين للداتا عن طريق ال كنرولر
                  Navigator.pop(context);
                  ProjectCubit.get(context).changebottomsheetstate(
                      isShow: false,
                      Icon: Icons.edit
                  );
                }
              }
              else{
                ScaffoldKey.currentState!.showBottomSheet((context) {

                   return Container(
                      color: Colors.grey[130],
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: namecontroller,
                                  type: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.agriculture,
                                  label: 'Crop Name',
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: datecontroller,
                                  type: TextInputType.datetime,
                                  onTap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-10-01'),
                                    ).then((value){
                                      datecontroller.text=DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.data_exploration_outlined,
                                  label: 'Crop date',
                                  radius: 20,
                                ),
                                SizedBox(height: 10,),
                                defaultFormField(
                                  controller: typecontroller,
                                  type: TextInputType.text,
                                  onTap: (){
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.type_specimen_outlined,
                                  label: 'Crop season',
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: temperaturecontroller,
                                  type: TextInputType.number,
                                  onTap: (){
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.sunny,
                                  label: 'Crop Teperature',
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                defaultFormField(
                                  controller: moisturecontroller,
                                  type: TextInputType.number,
                                  onTap: (){
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'required';
                                    }
                                    return null;
                                  },
                                  prefix: Icons.sunny_snowing,
                                  label: 'Crop moisture',
                                  radius: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     TextButton(onPressed: (){
                                    //       // ProjectCubit.get(context).UpdateData(
                                    //       //   CropName: namecontroller.text,
                                    //       //   CropDate: datecontroller.text,
                                    //       //   CropSeason: typecontroller.text,
                                    //       //   CropTemperature: temperaturecontroller.text,
                                    //       //   CropMoisture: moisturecontroller.text,
                                    //       // );
                                    //     }, child: Text("update")),
                                    //     Icon(
                                    //       Icons.update,
                                    //     ),
                                    //   ],
                                    // ),

                                    SizedBox(
                                      width: 90,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TextButton(onPressed: (){
                                          ProjectCubit.get(context).CreateData(
                                            CropName: namecontroller.text,
                                            CropDate: datecontroller.text,
                                            CropSeason: typecontroller.text,
                                            CropTemperature: temperaturecontroller.text,
                                            CropMoisture: moisturecontroller.text,
                                          );
                                        }, child: Text("upload")),
                                        Icon(
                                          Icons.upload,
                                        ),
                                      ],
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
              }
                ).closed.then((value) {
                  ProjectCubit.get(context).changebottomsheetstate(
                      isShow: false,
                      Icon: Icons.edit
                  );
                });
                ProjectCubit.get(context).changebottomsheetstate(
                    isShow: true,
                    Icon: Icons.add
                );
              }
            },
            child: Icon(ProjectCubit.get(context).fabicon),
          ),
        );
      }
    );
  }
  Widget builditem(context,DataModel datamodel)=>Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    child: Container(
      //margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[400],
      ),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 170,

      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Crop Name :"),
              SizedBox(height: 5,),
              Text("Crop Date :"),
              SizedBox(height: 5,),
              Text("Crop Season :"),
              SizedBox(height: 5,),
              Text("Crop Temperature :"),
              SizedBox(height: 5,),
              Text("Crop moisture :"),
            ],
          ),
          // SizedBox(width: 15,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${datamodel.CropName}"),
                SizedBox(height: 5,),
                Text("${datamodel.CropDate}"),
                SizedBox(height: 5,),
                Text("${datamodel.CropSeason}"),
                SizedBox(height: 5,),
                Text("${datamodel.CropTemperature}"),
                SizedBox(height: 5,),
                Text("${datamodel.CropMoisture}"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//Scaffold(
//       key: ScaffoldKey,
//       appBar: AppBar(
//         title: Text('Home_Page'),
//       ),
//       body: Container(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           if(isbottomsheetshown){
//             Navigator.pop(context);
//             isbottomsheetshown=false;
//             setState(() {
//               fabicon=Icons.edit;
//             });
//           }
//           else{
//             ScaffoldKey.currentState!.showBottomSheet((context) =>
//                 Container(
//                   color: Colors.grey[130],
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         defaultFormField(
//                           controller: namecontroller,
//                           type: TextInputType.text,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'password must not be empty';
//                             }
//                             return null;
//                           },
//                           prefix: Icons.agriculture,
//                           label: 'Crop Name',
//                           radius: 20,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             );
//             setState(() {
//               fabicon=Icons.add;
//             });
//             isbottomsheetshown=true;
//           }
//         },
//         child: Icon(fabicon),
//       ),
//);


//Scaffold(
//           key: ScaffoldKey,
//           body: ListView.separated(
//             itemBuilder: (context,index)=>builditem(),
//             separatorBuilder: (context,index)=>SizedBox(height: 0.0,),
//             itemCount: 5,
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: (){
//               if(ProjectCubit.get(context).isbottomsheetshown) {
//                 if(formKey.currentState!.validate()){
//                   //هنا ممكن نعمل ال تخزين للداتا عن طريق ال كنرولر
//                   ProjectCubit.get(context).CreateData(
//                       CropName: namecontroller.text,
//                       CropDate: datecontroller.text,
//                       CropSeason: typecontroller.text,
//                       CropTemperature: temperaturecontroller.text,
//                       CropMoisture: moisturecontroller.text,
//                   );
//                   Navigator.pop(context);
//                   ProjectCubit.get(context).changebottomsheetstate(
//                       isShow: false,
//                       Icon: Icons.edit
//                   );
//                   // setState(() {
//                   //   fabicon = Icons.edit;
//                   // });
//                 }
//
//               }
//               else{
//                 ScaffoldKey.currentState!.showBottomSheet((context) =>
//                     Container(
//                       color: Colors.grey[130],
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Form(
//                           key: formKey,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 defaultFormField(
//                                   controller: namecontroller,
//                                   type: TextInputType.text,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.agriculture,
//                                   label: 'Crop Name',
//                                   radius: 20,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 defaultFormField(
//                                   controller: datecontroller,
//                                   type: TextInputType.datetime,
//                                   onTap: (){
//                                     showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime.now(),
//                                       lastDate: DateTime.parse('2023-10-01'),
//                                     ).then((value){
//                                       datecontroller.text=DateFormat.yMMMd().format(value!);
//                                     });
//                                   },
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.data_exploration_outlined,
//                                   label: 'Crop date',
//                                   radius: 20,
//                                 ),
//                                 SizedBox(height: 10,),
//                                 defaultFormField(
//                                   controller: typecontroller,
//                                   type: TextInputType.text,
//                                   onTap: (){
//                                   },
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.type_specimen_outlined,
//                                   label: 'Crop season',
//                                   radius: 20,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 defaultFormField(
//                                   controller: temperaturecontroller,
//                                   type: TextInputType.number,
//                                   onTap: (){
//                                   },
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.sunny,
//                                   label: 'Crop Teperature',
//                                   radius: 20,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 defaultFormField(
//                                   controller: moisturecontroller,
//                                   type: TextInputType.number,
//                                   onTap: (){
//                                   },
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'required';
//                                     }
//                                     return null;
//                                   },
//                                   prefix: Icons.sunny_snowing,
//                                   label: 'Crop moisture',
//                                   radius: 20,
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                 ).closed.then((value) {
//                   ProjectCubit.get(context).changebottomsheetstate(
//                       isShow: false,
//                       Icon: Icons.edit
//                   );
//                 });
//                 ProjectCubit.get(context).changebottomsheetstate(
//                     isShow: true,
//                     Icon: Icons.add
//                 );
//               }
//             },
//             child: Icon(ProjectCubit.get(context).fabicon),
//           ),
//         );