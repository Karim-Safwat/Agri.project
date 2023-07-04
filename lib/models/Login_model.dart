// class LoginModel {
//
//   LoginModel.fromJson(dynamic json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   bool? status;
//   String? message;
//   Data? data;
//
//
// }
//
// class Data {
//
//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     points = json['points'];
//     credit = json['credit'];
//     token = json['token'];
//   }
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   int? points;
//   int? credit;
//   String? token;
//
//
// }