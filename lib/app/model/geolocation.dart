import 'dart:convert';

class Geolocation {
  final double? lat;
  final double? long;
  Geolocation({
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
    };
  }

  factory Geolocation.fromMap(Map<String, dynamic> map) {
    return Geolocation(
      lat: map['lat'] != null ? double.tryParse(map['lat']) : null,
      long: map['long'] != null ? double.tryParse(map['long']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: json['lat'] != null ? double.tryParse(json['lat'].toString()) : null,
      long: json['long'] != null ? double.tryParse(json['long'].toString()) : null,
    );
  }
}
