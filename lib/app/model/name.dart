import 'dart:convert';

class Name {
  final String? firstname;
  final String? lastname;

  Name({this.firstname, this.lastname});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      firstname: map['firstname'],
      lastname: map['lastname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(Map<String, dynamic> source) {
    return Name(
      firstname: source['firstname'],
      lastname: source['lastname'],
    );
  }
}
