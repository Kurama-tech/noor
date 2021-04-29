import 'dart:convert';
import 'package:noor/model/location.dart';
import 'package:noor/provider/timingsProvider.dart';

import 'package:noor/views/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noor/model/timings.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String _lat = "Loading..!";
  String _long = "Loading..!";
  Position _currentPosition;
  bool _locset = false;
  bool _progress = false;
  Future<Timings> timings;
  LocationModel loc;
  var now = new DateTime.now();

  @override
  void initState() {
    final timingsModel = Provider.of<TimingsProvider>(context, listen: false);
    final locationModel = Provider.of<LocationProvider>(context, listen: false);
    final locsetModel = Provider.of<LocationSet>(context, listen: false);

    _getCurrentLocation(timingsModel, locationModel, locsetModel);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _home(context);
  }

  Widget _home(context) {
    final timingsM = Provider.of<TimingsProvider>(context);
    return Center(
        child: _progress || timingsM.loading
            ? Container(
                child: CircularProgressIndicator(),
              )
            : ListView(padding: const EdgeInsets.all(8), children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          /*  ListTile(
                      leading: Icon(CupertinoIcons.hourglass_bottomhalf_fill),
                      title: Text("Fajr : 5:00 am"),
                      subtitle: Text("15 min's left"),
                    ),
                    Divider(
                      height: 10,
                      thickness: 3,
                    ), */
                          ListTile(
                            title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Text("Today's Timings")]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Chip(
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.grey.shade800,
                                  child: Icon(CupertinoIcons.sunrise),
                                ),
                                label: Text(
                                    convertdate12(timingsM.timings.sunrise)),
                              ),
                              const SizedBox(width: 8),
                              Chip(
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.grey.shade800,
                                  child: Icon(CupertinoIcons.sunset),
                                ),
                                label: Text(
                                    convertdate12(timingsM.timings.sunset)),
                              ),
                              const SizedBox(width: 8),
                              Chip(
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.grey.shade800,
                                  child: Icon(CupertinoIcons.moon_stars),
                                ),
                                label: Text(
                                    convertdate12(timingsM.timings.midnight)),
                              )
                            ],
                          ),
                          Divider(
                            height: 10,
                            thickness: 3,
                          ),
                          ListTile(
                            title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[Text("Prayer Timings")]),
                          ),
                          DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Prayer',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Start Time',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'End Time',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Fajr')),
                                  DataCell(Text(
                                      convertdate12(timingsM.timings.fajr))),
                                  DataCell(
                                      Text(convertdate(timingsM.timings.fajr))),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Dhur')),
                                  DataCell(Text(
                                      convertdate12(timingsM.timings.dhur))),
                                  DataCell(
                                      Text(convertdate(timingsM.timings.dhur))),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Asr')),
                                  DataCell(Text(
                                      convertdate12(timingsM.timings.asr))),
                                  DataCell(
                                      Text(convertdate(timingsM.timings.asr))),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Maghrib')),
                                  DataCell(Text(
                                      convertdate12(timingsM.timings.maghrib))),
                                  DataCell(Text(
                                      convertdate(timingsM.timings.maghrib))),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Isha')),
                                  DataCell(Text(
                                      convertdate12(timingsM.timings.isha))),
                                  DataCell(
                                      Text(convertdate(timingsM.timings.isha))),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Qiyam')),
                                  DataCell(Text(
                                      convertdate12(timingsM.timings.imsak))),
                                  DataCell(Text(
                                      convertdate(timingsM.timings.imsak))),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 10,
                            thickness: 3,
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.sun_min),
                            title: Text("Morning Zikr"),
                            subtitle: Text(zikr(timingsM.timings.fajr)),
                          ),
                          Divider(
                            height: 10,
                            thickness: 3,
                          ),
                          ListTile(
                            leading: Icon(CupertinoIcons.moon_zzz),
                            title: Text("Evening Zikr"),
                            subtitle: Text(zikr(timingsM.timings.asr)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]));
  }

  _getCurrentLocation(TimingsProvider timingsModel,
      LocationProvider locationModel, LocationSet locsetModel) async {
    print(locsetModel.locset);
    if (!locsetModel.locset) {
      setState(() {
        _progress = true;
      });
      LocationPermission permission = await Geolocator.checkPermission();
      print(permission);
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        print(position);
        print(DateTime.now().toString());
        timings = fetchTimings(position.latitude.toString(),
            position.longitude.toString(), DateTime.now().toString());
        timings.then((value) => timingsModel.setTimingsData(value));
        loc = LocationModel.setloc(position, position.latitude.toString(),
            position.longitude.toString());
        locationModel.setLocationData(loc);
        locsetModel.setloc(true);
        setState(() {
          _progress = false;
          _locset = true;
          _currentPosition = position;
          _lat = position.latitude.toString();
          _lat = position.longitude.toString();
        });
      }).catchError((e) {
        print(e);
        _progress = false;
      });
    }
  }

  convertdate(String d) {
    var date = DateTime.parse("2020-01-20 " + d);
    var pdate = date.add(Duration(minutes: 15));
    var newdate = DateFormat("h:mma").format(pdate);

    return newdate.toString();
  }

  convertdate12(String d) {
    var date = DateTime.parse("2020-01-20 " + d);
    var newdate = DateFormat("h:mma").format(date);

    return newdate.toString();
  }

  zikr(String d) {
    var date = DateTime.parse("2020-01-20 " + d);
    var pdate = date.add(Duration(minutes: 30));
    var newdate = DateFormat("h:mma").format(pdate);

    return newdate.toString();
  }

  /*  nextprayer(String fajr, String dhur, String asr, String magrib, String isha){
    var now = DateTime.now();
    var hour = now.hour.toString();
    var dates = [];
    dates.add(DateTime.parse("2020-01-20 "+fajr));
    dates.add(DateTime.parse("2020-01-20 "+dhur));
    dates.add(DateTime.parse("2020-01-20 "+asr));
    dates.add(DateTime.parse("2020-01-20 "+magrib));
    dates.add(DateTime.parse("2020-01-20 "+isha));
     
} */
}

Future<Timings> fetchTimings(String lat, String long, String date) async {
  var queryParams = {'date': date, 'lon': long, 'lat': lat};

  var uri =
      Uri.https('api.nooremahdavia.com', "/prayer_timings/day", queryParams);

  print(uri);

  var dio = Dio();
  final response = await dio.get(uri.toString());

  if (response.statusCode == 200) {
    print(response.data);
    return Timings.fromJson(jsonDecode(response.toString()));
  } else {
    throw Exception('Failed to load prayer timings');
  }
}
