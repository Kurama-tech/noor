import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:noor/model/books.dart';
import 'package:noor/model/mosquesModel.dart';
import 'package:noor/model/photos.dart';
import 'package:noor/model/quotes.dart';
import 'package:noor/model/timings.dart';
import 'package:noor/model/location.dart';
import 'package:noor/model/videos.dart';
import 'package:latlong/latlong.dart';

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
  LatLng latlang;
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

class BooksProvider with ChangeNotifier {
  List<Books> booksData;
  bool flag = false;

  setdata() {
    fetchBooks().then((value) {
      booksData = value;
      flag = true;
      notifyListeners();
    });
  }

  List<Books> getBooks() {
    return booksData;
  }

  Future<List<Books>> fetchBooks() async {
    var uri = Uri.https('api.nooremahdavia.com', "/media/book");
    // ignore: non_constant_identifier_names
    List<Books> ListModel = [];
    print(uri);
    var dio = Dio();
    final response = await dio.get(uri.toString());

    if (response.statusCode == 200) {
      //print(response.body.toString());
      final data = jsonDecode(response.toString());

      for (Map i in data['results']) {
        //print(i);
        ListModel.add(Books.fromJson(i));
      }
      return ListModel;
    } else {
      throw Exception('Failed to load Books');
    }
  }
}

class QuotesProvider with ChangeNotifier {
  List<Quotes> quotes;
  bool flag = false;

  setdata() {
    fetchQuotes().then((value) {
      quotes = value;
      flag = true;
      notifyListeners();
    });
  }

  Future<List<Quotes>> fetchQuotes() async {
    var uri = Uri.https('api.nooremahdavia.com', "/media/quote");
    List<Quotes> ListModel = [];
    print(uri);
    var dio = Dio();
    final response = await dio.get(uri.toString());

    if (response.statusCode == 200) {
      //print(response.body.toString());
      final data = jsonDecode(response.toString());

      for (Map i in data['results']) {
        //print(i);
        ListModel.add(Quotes.fromJson(i));
      }
      return ListModel;
    } else {
      throw Exception('Failed to load Quotes');
    }
  }
}

class VideosProvider with ChangeNotifier {
  List<Videos> videos;
  bool flag = false;

  setdata() {
    fetchvideos().then((value) {
      videos = value;
      flag = true;
      notifyListeners();
    });
  }

  Future<List<Videos>> fetchvideos() async {
    var uri = Uri.https('api.nooremahdavia.com', "/media/video");
    List<Videos> ListModel = [];
    print(uri);

    var dio = Dio();
    final response = await dio.get(uri.toString());

    if (response.statusCode == 200) {
      //print(response.body.toString());
      final data = jsonDecode(response.toString());

      for (Map i in data['results']) {
        //print(i);
        if (i['name'] != "") {
          ListModel.add(Videos.fromJson(i));
        }
      }
      return ListModel;
    } else {
      throw Exception('Failed to load Videos');
    }
  }
}

class PhotoProvider with ChangeNotifier {
  List<Photos> photos;
  bool flag = false;

  setdata() {
    fetchphoto().then((value) {
      photos = value;
      flag = true;
      notifyListeners();
    });
  }

  Future<List<Photos>> fetchphoto() async {
    var uri = Uri.https('api.nooremahdavia.com', "/media/photo");
    List<Photos> ListModel = [];
    print(uri);

    var dio = Dio();
    final response = await dio.get(uri.toString());

    if (response.statusCode == 200) {
      //print(response.toString());
      final data = jsonDecode(response.toString());

      for (Map i in data['results']) {
        //print(i);
        ListModel.add(Photos.fromJson(i));
      }
      return ListModel;
    } else {
      throw Exception('Failed to load Photos');
    }
  }
}

class MapsProvider with ChangeNotifier {
  ConcatMD data;

  bool flag = false;
  setdata() {
    fetchMaps().then((value) {
      data = value;
      flag = true;
      notifyListeners();
    });
  }

  Future<ConcatMD> fetchMaps() async {
    var uri = Uri.https('api.nooremahdavia.com', "/mosques");
    List<MosquesDairah> mosques = [];
    List<MosquesDairah> dairahs = [];

    var dio = Dio();
    final response = await dio.get(uri.toString());

    if (response.statusCode == 200) {
      //print(response.toString());
      final data = jsonDecode(response.toString());

      for (Map i in data['mosques']) {
        //print(i);
        mosques.add(MosquesDairah.fromJson(i));
      }
      for (Map i in data['dairahs']) {
        dairahs.add(MosquesDairah.fromJson(i));
      }

      ConcatMD finaldata = new ConcatMD(mosques: mosques, dairahs: dairahs);
      return finaldata;
    } else {
      throw Exception('Failed to load Photos');
    }
  }
}
