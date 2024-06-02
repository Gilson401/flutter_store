import 'dart:convert';

import 'package:flutter_store/app/model/geolocation.dart';

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Address({this.geolocation, this.city, this.street, this.number, this.zipcode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'geolocation': geolocation?.toMap(),
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      geolocation: Geolocation.fromMap(map['geolocation'] as Map<String, dynamic>),
      city: map['city'] ,
      street: map['street'] ,
      number: map['number'] ,
      zipcode: map['zipcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(Map<String,dynamic> map) {
    return Address(
      geolocation : Geolocation.fromJson(map['geolocation'] ),
      city : map['city'] ,
      street : map['street'] ,
      number : map['number'] ,
      zipcode : map['zipcode'] ,
    );
  }

}
