
import 'dart:convert';
import 'package:flutter_store/app/model/address.model.dart';
import 'package:flutter_store/app/model/name.dart';

class UserManager {
  
  final Address? address;
  final dynamic id;
  final String? email;
  final String? userName;
  final String? phone;
  final String? photoUrl;

  final Name? name;
  final String? token;
  UserManager({
    this.address,
    required this.id,
    this.email,
    this.userName,
    this.phone,
    this.name,
    this.token,
    this.photoUrl,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toMap(),
      'id': id,
      'email': email,
      'userName': userName,
      'phone': phone,
      'name': name?.toMap(),
      'token': token,
      'photoUrl': photoUrl,
    };
  }

  factory UserManager.fromMap(Map<String, dynamic> map) {
    return UserManager(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      id: map['id'] as dynamic,
      email: map['email'],
      userName: map['username'],
      phone: map['phone'],
      name: map['name'] != null ?  Name.fromMap( map['name']) : null,
      token: map['token'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() {
    String encoded = json.encode(toMap());
    return encoded;
  }

  factory UserManager.fromJson(Map<String, dynamic> map) {

    return UserManager(
      id: map['id'] ,
      email: map['email'],
      userName: map['username'],
      phone: map['phone'],
      token: map['token'],
      photoUrl: map['photoUrl'],
      name: map['name'] != null ? Name.fromJson(map['name']) : null,
      address: map['address'] != null ? Address.fromJson(map['address'] ) : null,
    );
  }
}
