import 'package:final_agriculture_project/models/Login_model.dart';

abstract class ProjectLoginStates {}

class ProjectLoginInitialState extends ProjectLoginStates{}

class ChangePasswordVisibility extends ProjectLoginStates{}

class ProjectLoginLoadingState extends ProjectLoginStates{}
class ProjectLoginSuccessState extends ProjectLoginStates
{
  // final LoginModel loginModel;
  //
  // ProjectLoginSuccessState(this.loginModel);
  final String uid;
  ProjectLoginSuccessState(this.uid);
}
class ProjectLoginErrorState extends ProjectLoginStates
{
  final String error;

  ProjectLoginErrorState(this.error);
}