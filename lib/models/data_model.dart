class DataModel{
  String? CropName;
  String? CropDate;
  String? CropSeason;
  String? CropTemperature;
  String? CropMoisture;
   String? uid;
  //bool? isEmailVerified;
  DataModel({
     this.CropName,
     this.CropDate,
     this.CropSeason,
     this.CropTemperature,
    //this.image,
     this.CropMoisture,
    this.uid
    //this.isEmailVerified,
  });
  DataModel.fromJson(dynamic json)
  {
    CropName=json['CropName'];
    CropDate=json['CropDate'];
    CropSeason=json['CropSeason'];
    CropTemperature=json['CropTemperature'];
    uid=json['uid'];
    CropMoisture=json['CropMoisture'];
    //isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap()
  {
    return{
      'CropName':CropName,
      'CropDate':CropDate,
      'CropSeason':CropSeason,
      'CropTemperature':CropTemperature,
      'uid':uid,
      'CropMoisture':CropMoisture,
      //'isEmailVerified':isEmailVerified,
    };
  }
}