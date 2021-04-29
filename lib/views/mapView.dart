import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:noor/provider/timingsProvider.dart';
import 'package:provider/provider.dart';

const maxMarkersCount = 5000;

/// On this page, [maxMarkersCount] markers are randomly generated
/// across europe, and then you can limit them with a slider
///
/// This way, you can test how map performs under a lot of markers
class ManyMarkersPage extends StatefulWidget {
  static const String route = '/many_markers';

  @override
  _ManyMarkersPageState createState() => _ManyMarkersPageState();
}

class _ManyMarkersPageState extends State<ManyMarkersPage> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];

  int _sliderVal = maxMarkersCount ~/ 10;

  @override
  void initState() {
    super.initState();
    /* Future.microtask(() {
      var r = Random();
      for (var x = 0; x < maxMarkersCount; x++) {
        allMarkers.add(
          Marker(
            point: LatLng(
              doubleInRange(r, 37, 55),
              doubleInRange(r, -9, 30),
            ),
            builder: (context) => const Icon(
              Icons.circle,
              color: Colors.red,
              size: 12.0,
            ),
          ),
        );
      }
      setState(() {});
    }); */
  }

  @override
  Widget build(BuildContext context) {
    final locationModel = Provider.of<LocationProvider>(context);
    print(locationModel.location.lat);
    print(locationModel.location.long);
    return Column(
      children: [
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(double.parse(locationModel.location.lat),
                  double.parse(locationModel.location.long)),
              zoom: 7.0,
              interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: [
                Marker(
                  point: LatLng(double.parse(locationModel.location.lat),
                      double.parse(locationModel.location.long)),
                  builder: (context) => const Icon(
                    Icons.location_city,
                    color: Colors.red,
                    size: 35.0,
                  ),
                )
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
