import 'dart:convert';

List<MosquesDairah> modelMosquesDairahFromJson(String str) =>
    List<MosquesDairah>.from(
        json.decode(str).map((x) => MosquesDairah.fromJson(x)));

String modelMosquesDairahToJson(List<MosquesDairah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MosquesDairah {
  final String address;
  final String name;
  final int type;
  final double latitude;
  final double longitude;

  MosquesDairah(
      {this.address, this.name, this.type, this.latitude, this.longitude});

  factory MosquesDairah.fromJson(Map<String, dynamic> json) {
    return MosquesDairah(
        address: json['address'],
        name: json['name'],
        type: json['type'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "name": name,
        "type": type,
        "latitude": latitude,
        "longitude": longitude
      };
}

class ConcatMD {
  final List<MosquesDairah> mosques;
  final List<MosquesDairah> dairahs;

  ConcatMD({this.mosques, this.dairahs});

}
