import 'package:final_agriculture_project/models/Login_model.dart';
import 'package:final_agriculture_project/modules/login/cubit/states.dart';
import 'package:final_agriculture_project/network/remote/Dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectLoginCubit extends Cubit<ProjectLoginStates>
{
  ProjectLoginCubit() : super(ProjectLoginInitialState());

  static ProjectLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibility());
  }

  // LoginModel? loginModel; احتمال كبير مش عايزينها
  //
  void loginUser({
    required String email,
    required String password,
  }) {
    emit(ProjectLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.email);
      print(value.user!.uid);
      emit(ProjectLoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(ProjectLoginErrorState(error.toString()));
    });
  }
}