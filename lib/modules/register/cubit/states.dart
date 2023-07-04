abstract class ProjectRegisterStates {}

class ProjectRegisterInitialState extends ProjectRegisterStates{}

class ChangePassVisibility extends ProjectRegisterStates{}

class ProjectRegisterLoadingState extends ProjectRegisterStates{}
class ProjectRegisterSuccessState extends ProjectRegisterStates
{
  // final LoginModel loginModel;
  //
  // ShopRegisterSuccessState(this.loginModel);
}
class ProjectRegisterErrorState extends ProjectRegisterStates
{
  final String error;

  ProjectRegisterErrorState(this.error);
}
class ProjectCreateUserSuccessState extends ProjectRegisterStates{}
class ProjectCreateUserErrorState extends ProjectRegisterStates
{
  final String error;

  ProjectCreateUserErrorState(this.error);
}
//class ProjectUserUpdateErrorState extends ProjectRegisterStates{}