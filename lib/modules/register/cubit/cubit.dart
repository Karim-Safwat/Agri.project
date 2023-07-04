import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_agriculture_project/models/user_model.dart';
import 'package:final_agriculture_project/modules/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProjectRegisterCubit extends Cubit<ProjectRegisterStates>
{
  ProjectRegisterCubit() : super(ProjectRegisterInitialState());

  static ProjectRegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePassVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePassVisibility());
  }

  //LoginModel? loginModel;  احتمال كبير مش عايزينها

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
    // required String image,

  })
  {
    emit(ProjectRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          name: name,
          phone: phone,
          email:email,
         // image: image,
          uid: value.user!.uid!,
      );
     // emit(ProjectRegisterSuccessState());
      // ممكن نشيل ال كومنت بس بعد م تعمل ريجستر هياخد وقت عقبال م ينقل
    }).catchError((error){
      emit(ProjectRegisterErrorState(error.toString()));
    });
  }
void userCreate({
  required String name,
  required String phone,
  required String email,
  required String uid,
  //required String image,
}){
    UserModel model=UserModel(
      name: name,
      phone: phone,
      email: email,
      uid: uid,
      //image:'https://img.freepik.com/free-photo/young-farmer-taking-care-his-business_329181-15967.jpg?w=996&t=st=1683421899~exp=1683422499~hmac=46a1808f44a22393a2ae704543e4d7a074d2b1cb8a19df1a7760aeef29da05d3',
      bio: 'write your bio..',
      isEmailVerified: false,
    );
 FirebaseFirestore.instance
     .collection('users')
     .doc(uid)
     .set(model.toMap()).then((value){
emit(ProjectCreateUserSuccessState());
 }).catchError((error){
   print(error.toString());
emit(ProjectCreateUserErrorState(error.toString())
);
 });
}


}
