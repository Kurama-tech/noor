import 'package:flutter/material.dart';
import 'package:noor/model/timings.dart';
import 'package:noor/model/location.dart';

class TimingsProvider with ChangeNotifier {
  Timings timings = Timings();
  bool loading = true;

  setTimingsData(data) {
    loading = true;
    timings = data;
    loading = false;
    notifyListeners();
  }
}

class LocationProvider with ChangeNotifier {
  LocationModel location = LocationModel();

  setLocationData(data) {
    location = data;
    notifyListeners();
  }
}

class LocationSet with ChangeNotifier {
  bool locset = false;

  setloc(data) {
    locset = data;
    notifyListeners();
  }
}
