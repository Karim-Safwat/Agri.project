

class UserModel{
  String? name;
   String? email;
  String? phone;
  String? uid;
  //String? image;
  String? bio;
  bool? isEmailVerified;
  UserModel({
    this.email,
    this.uid,
    this.phone,
    this.name,
    //this.image,
    this.bio,
    this.isEmailVerified,
  });
  UserModel.fromJson(dynamic json)
  {
  email=json['email'];
  name=json['name'];
  phone=json['phone'];
  uid=json['uid'];
  //image=json['image'];
  bio=json['bio'];
  isEmailVerified=json['isEmailVerified'];
  }
  Map<String,dynamic> toMap()
  {
    return{
      'email':email,
      'name':name,
      'phone':phone,
      'uid':uid,
      //'image':image,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}