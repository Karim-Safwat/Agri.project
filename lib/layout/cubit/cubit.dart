
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_agriculture_project/components/constants.dart';
import 'package:final_agriculture_project/layout/cubit/states.dart';
import 'package:final_agriculture_project/models/data_model.dart';
import 'package:final_agriculture_project/models/user_model.dart';

import 'package:final_agriculture_project/modules/control.dart';
import 'package:final_agriculture_project/modules/home.dart';
import 'package:final_agriculture_project/modules/notes.dart';
import 'package:final_agriculture_project/modules/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProjectCubit extends Cubit<ProjectStates> {
  ProjectCubit() :super(ProjectInitialStates());

  static ProjectCubit get(context) => BlocProvider.of(context);
  UserModel? model;

  void GetUserData() {
    emit(ProjectGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid).get()
        .then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data());
      emit(ProjectGetUserSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(ProjectGetUserErrorState(error.toString()));
    });
  }

  int CurrentIndex = 0;
  List<Widget> Screens = [
    Home_Screen(),
    Control_Screen(),
    Notes_Screen(),
    Settings_Screen()
  ];

  List<String>Titles = [
    'Data_page',
    'Control_page',
    'Notes_page',
    'Settings_Page'
  ];

  void ChangeBottomNav(int Index) {
      CurrentIndex = Index;
      emit(ProjectChangeBottomNavState());

  }

  // File? profileimage;
  // var picker=ImagePicker();
  // Future<void>getImage()async{
  //   final pickedFile= await picker.getImage(source:ImageSource.gallery,);
  //   if(pickedFile !=null){
  //      profileimage=File(pickedFile.path);
  //      print(pickedFile.path);
  //     emit(ProjectImagePickedSucessState());
  //   }
  //   else{
  //     print("No Image Selected.");
  //     emit(ProjectImagePickedErrorState());
  //   }
  // }

///data/user/0/com.example.final_agriculture_project/cache/image_picker6030945446697531294.jpg
//   var profileimageUrl;
// void uploadprofileimage(){
//     firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
//         .putFile(profileimage!)
//         .then((value) {
//           value.ref.getDownloadURL().then((value) {
//             emit(ProjectUploadProfileImageSucessState());
//             print(value);
//             profileimageUrl=value;
//           }).catchError((error){
//             emit(ProjectUploadProfileImageErrorState());
//           });
//     })
//         .catchError((error){
//       emit(ProjectUploadProfileImageErrorState());
//     });
//
//   }
  
//   void updateUserImage(
//   {
//     required String name,
//     required String phone,
//     required String bio,
//     required String email,
//   }
//       ){
//   emit(ProjectUserUpdateLoadingState());
// // if(profileimage ==null) {
// //   uploadprofileimage();
// //}
// //else{
//   updateUserData(
//     name: name,
//     phone: phone,
//     bio: bio,
//     email: email,
//   );
// }
// }

void updateUserData(
    {
      required String name,
      required String phone,
      required String bio,
      required String email,
    }
    ){
  UserModel model=UserModel(
    name: name,
    phone: phone,
    bio: bio,
    //image: 'https://img.freepik.com/free-photo/young-farmer-taking-care-his-business_329181-15967.jpg?w=996&t=st=1683421899~exp=1683422499~hmac=46a1808f44a22393a2ae704543e4d7a074d2b1cb8a19df1a7760aeef29da05d3',
    email: email,
    uid: uid,
    isEmailVerified: false,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(uid).update(model.toMap())
      .then((value) {
    GetUserData();
  }).catchError((){
    emit(ProjectUserUpdateErrorState());
  });
}
  bool isbottomsheetshown=false;
  IconData fabicon=Icons.edit;

  void changebottomsheetstate({
  required bool isShow,
    required IconData Icon,
}){
    isbottomsheetshown=isShow;
    fabicon=Icon;
    emit(ChangeIconBottomSheetState());
  }


  DataModel? datamodel;
  Future CreateData({
    required String CropName,
    required String CropDate,
    required String CropSeason,
    required String CropTemperature,
    required String CropMoisture,
    String? uid,
  }) {

    DataModel datamodel = DataModel(
      CropName: CropName,
      CropDate: CropDate,
      CropSeason: CropSeason,
      //uid: model!.uid,
      CropTemperature: CropTemperature,
      CropMoisture: CropMoisture,

    );
return
    FirebaseFirestore.instance
        .collection('data')
        //.doc(uid)
        .add(datamodel.toMap()).then((value) {
      emit(ProjectCreateDataSucessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProjectCreateDataErrorState()
      );
    });
  }

  List<DataModel> field=[];

  void SendData(){
    FirebaseFirestore.instance
        .collection('data')
        .get()
        .then((value) {
          field.clear();
          value.docs.forEach((element) {

            field.add(DataModel.fromJson(element.data()));
          });
          emit(ProjectCSendDataSucessState());
    })
        .catchError((error){
          emit(ProjectSendDataErrorState(error.toString()));
    });
  }

  //DataModel? datamodel;
  // Future UpdateData({
  //   required String CropName,
  //   required String CropDate,
  //   required String CropSeason,
  //   required String CropTemperature,
  //   required String CropMoisture,
  //   String? uid,
  // }) {
  //
  //   DataModel datamodel = DataModel(
  //     CropName: CropName,
  //     CropDate: CropDate,
  //     CropSeason: CropSeason,
  //     //uid: model!.uid,
  //     CropTemperature: CropTemperature,
  //     CropMoisture: CropMoisture,
  //
  //   );
  //   return
  //     FirebaseFirestore.instance
  //         .collection('data')
  //     .doc(uid)
  //         .update(datamodel.toMap()).then((value) {
  //      // emit(ProjectCreateDataSucessState());
  //     }).catchError((error) {
  //       print(error.toString());
  //     //  emit(ProjectCreateDataErrorState());
  //     });
  // }


  // bool iswateropen=false;
  // IconData watericon=Icons.open;
  //
  // void changebottomsheetstate({
  //   required bool isShow,
  //   required IconData Icon,
  // }){
  //   isbottomsheetshown=isShow;
  //   fabicon=Icon;
  //   emit(ChangeIconBottomSheetState());
  // }
}