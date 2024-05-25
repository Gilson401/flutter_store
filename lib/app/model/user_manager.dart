import 'package:flutter_store/app/model/rating_model.dart';

class UserManager {
  final dynamic id;
  final String? userName;
  final String? fullName;
  final String? email;
  final String? token;

  UserManager({this.id, this.userName, this.fullName, this.email, this.token});

  factory UserManager.fromJson(Map<String, dynamic> json) => UserManager(
        id: json["id"],
        userName: json["username"],
        fullName: json['full_name'],
        email: json['email'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["username"] = userName;
    data['full_name'] = fullName;
    data['email'] = email;
    data['token'] = token;

    return data;
  }
}
