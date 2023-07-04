


import 'dart:io';

import 'package:final_agriculture_project/components/components.dart';
import 'package:final_agriculture_project/components/constants.dart';
import 'package:final_agriculture_project/layout/cubit/cubit.dart';
import 'package:final_agriculture_project/layout/cubit/states.dart';
import 'package:final_agriculture_project/modules/login/Login_Screen.dart';
import 'package:final_agriculture_project/modules/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Settings_Screen extends StatelessWidget {
  var mailcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var namecontroller=TextEditingController();
  var biocontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(
      listener: (context,state){

      },
      builder: (context,state){
      // var image=ProjectCubit.get(context).profileimage;

        var usermodel=ProjectCubit.get(context).model;
        mailcontroller.text='${usermodel?.email}';
        phonecontroller.text='${usermodel?.phone}';
        namecontroller.text='${usermodel?.name}';
        biocontroller.text='${usermodel?.bio}';

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage:NetworkImage('https://img.freepik.com/free-photo/young-farmer-taking-care-his-business_329181-15967.jpg?w=996&t=st=1683421899~exp=1683422499~hmac=46a1808f44a22393a2ae704543e4d7a074d2b1cb8a19df1a7760aeef29da05d3'),
                        //image==null? NetworkImage('${usermodel!.image}')as ImageProvider:FileImage(image) ,
                        //NetworkImage('${usermodel!.image}')
                      ),

                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundColor: Colors.white,
                      //   child: IconButton(onPressed: (){
                      //     ProjectCubit.get(context).getImage();
                      //   },
                      //       splashColor: Colors.white,
                      //       icon:Icon(Icons.camera_alt)
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                            label:Text("User Name"),
                            // labelStyle: Theme.of(context).textTheme.bodyText1,
                            prefixIcon: Icon(Icons.person),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        controller: namecontroller,
                        validator: (value){
                          if(value!.isEmpty){
                            return "name must not be null";
                          }
                        },
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    IconButton(onPressed: (){

                    },
                        splashColor: Colors.white,
                        icon:Icon(Icons.edit,
                          color: Colors.grey,
                        )
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                            label:Text("Bio"),
                            // labelStyle: Theme.of(context).textTheme.bodyText1,
                            prefixIcon: Icon(Icons.speaker_notes),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        controller: biocontroller,
                        validator: (value){
                          if(value!.isEmpty){
                            return "name must not be null";
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    IconButton(onPressed: (){

                    },
                        splashColor: Colors.white,
                        icon:Icon(Icons.edit,
                          color: Colors.grey,
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                            label:Text("Mail Address"),
                            // labelStyle: Theme.of(context).textTheme.bodyText1,
                            prefixIcon: Icon(Icons.mail),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        controller: mailcontroller,
                        validator: (value){
                          // if(value!.isEmpty){
                          //
                          // }
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    // IconButton(onPressed: (){
                    //
                    // },
                    //     splashColor: Colors.white,
                    //     icon:Icon(Icons.edit,
                    //       color: Colors.grey,
                    //     )
                    // ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                            label:Text("Phone Number"),
                            // labelStyle: Theme.of(context).textTheme.bodyText1,
                            prefixIcon: Icon(Icons.phone),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                        controller: phonecontroller,
                        validator: (value){
                          // if(value!.isEmpty){
                          //
                          // }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(onPressed: (){

                    },
                        splashColor: Colors.white,
                        icon:Icon(Icons.edit,
                        color: Colors.grey,
                        )
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                if(state is ProjectUserUpdateLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child:OutlinedButton(
                        onPressed: (){
                          //ProjectCubit.get(context).GetUserData();
                          ProjectCubit.get(context).updateUserData(
                              name: namecontroller.text,
                              phone: phonecontroller.text,
                              bio: biocontroller.text,
                             // image: ProjectCubit.get(context).profileimageUrl,
                              email: mailcontroller.text

                          );
                        },
                        child:Text("Update") ,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(

                        child:OutlinedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const Notes_Screen(),
                              ),
                            );
                          },
                          child:Text("Add Notes") ,
                        ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(

                      child:OutlinedButton(
                        onPressed: (){
                          signOut(context);
                          // Navigator.pushAndRemoveUntil(
                          //   context, MaterialPageRoute(builder: (context) =>LoginScreen()),
                          //       (Route<dynamic>route)=>false,
                          // );
                        },
                        child:Text("Sign Out") ,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
    },
    );
  }
}