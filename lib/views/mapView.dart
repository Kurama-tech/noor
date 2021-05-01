import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:noor/model/mosquesModel.dart';
import 'package:noor/provider/timingsProvider.dart';
import 'package:provider/provider.dart';

class FullMap extends StatefulWidget {
  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMapController mapController;

  @override
  void initState() {
    final markersModel = Provider.of<MapsProvider>(context, listen: false);
    if (!markersModel.flag) {
      markersModel.setdata();
    }
    super.initState();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    mapController.onSymbolTapped.add((argument) {
      MosquesDairah symbolData = MosquesDairah.fromJson(argument.data);
      /*    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          content: Text(symbolData.name),
          action: SnackBarAction(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            label: 'Navigate',
          ),
        ),
      ); */
      displayModalBottomSheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationModel = Provider.of<LocationProvider>(context);
    final markersModel = Provider.of<MapsProvider>(context);
    return Center(
        child: !markersModel.flag
            ? Container(
                child: CircularProgressIndicator(),
              )
            : MapboxMap(
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                accessToken:
                    '',
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                    zoom: 1.0,
                    target: LatLng(double.parse(locationModel.location.lat),
                        double.parse(locationModel.location.long))),
                onStyleLoadedCallback: () =>
                    addSymbols(mapController, markersModel.data)));
  }

  void addSymbols(MapboxMapController mapBoxController, ConcatMD data) {
    addSymbolsMD(mapBoxController, data.mosques);
    addSymbolsMD(mapBoxController, data.dairahs);
  }

  void addSymbolsMD(
      MapboxMapController mapBoxController, List<MosquesDairah> data) {
    //List<SymbolOptions> markers = [];
    for (MosquesDairah i in data) {
      LatLng latLng = LatLng(i.latitude, i.longitude);
      SymbolOptions symbol = new SymbolOptions(
        geometry: latLng,
        iconImage: 'assets/pin_mosque.png',
        iconSize: 3,
      );
      //markers.add(symbol);
      mapController.addSymbol(symbol, i.toJson());
    }
  }
}

void displayModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.music_note),
                  title: new Text('Music'),
                  subtitle: new Text('Address'),
                  trailing: new MaterialButton( child: Text("Navigate") ,onPressed: () => {}),
                ),
              ],
            ),
          ),
        );
      });
}
