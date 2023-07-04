abstract class ProjectStates{}

class ProjectInitialStates extends ProjectStates{}

class ProjectGetUserLoadingState extends ProjectStates{}

class ProjectGetUserSuccessState extends ProjectStates{}

class ProjectGetUserErrorState extends ProjectStates{
  final String error;
  ProjectGetUserErrorState(this.error);
}

class ProjectChangeBottomNavState extends ProjectStates{}
//class ProjectAddCropState extends ProjectStates{}

class ProjectImagePickedSucessState extends ProjectStates{}

class ProjectImagePickedErrorState extends ProjectStates{}

class ProjectUploadProfileImageSucessState extends ProjectStates{}

class ProjectUploadProfileImageErrorState extends ProjectStates{}

class ProjectUserUpdateErrorState extends ProjectStates{}

class ProjectUserUpdateLoadingState extends ProjectStates{}

class ChangeIconBottomSheetState extends ProjectStates{}

class ProjectCreateDataLoadingState extends ProjectStates{}

class ProjectCreateDataSucessState extends ProjectStates{}

class ProjectCreateDataErrorState extends ProjectStates{}

class ProjectSendDataLoadingState extends ProjectStates{}

class ProjectCSendDataSucessState extends ProjectStates{}

class ProjectSendDataErrorState extends ProjectStates{
  final String error;

  ProjectSendDataErrorState(this.error);

}