import 'package:geolocator/geolocator.dart';

class LocationModel {
  Position currentPosition;
  String lat;
  String long;
  bool locset = false;

  LocationModel({this.currentPosition, this.lat, this.long, this.locset});

  factory LocationModel.setloc(Position p, String lati, String longi) {
    return LocationModel(
      currentPosition: p,
      lat: lati,
      long: longi,
    );
  }
}
