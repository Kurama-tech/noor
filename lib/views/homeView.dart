import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noor/views/calenderView.dart';

import 'package:noor/views/homePageView.dart';
import 'package:noor/views/mapView.dart';
import 'package:noor/views/qiblaView.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/pandabar.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:noor/views/mediaView.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  static const title = "Noor-e-Mehdavia";

  var page = 'Grey';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(width: 2, color: Colors.white)),
        titleSpacing: 7.0,
        title: Container(
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        elevation: 3.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.greenAccent,
            systemNavigationBarIconBrightness: Brightness.dark),
      ),
      extendBody: true,
      extendBodyBehindAppBar: false,
      bottomNavigationBar: PandaBar(
        fabIcon: FaIcon(FontAwesomeIcons.kaaba),
        backgroundColor: Theme.of(context).primaryColor,
        buttonData: [
          PandaBarButtonData(id: 'Grey', icon: Icons.home, title: 'Home'),
          PandaBarButtonData(
              id: 'Blue', icon: Icons.calendar_today, title: 'Calender'),
          PandaBarButtonData(id: 'Red', icon: Icons.place, title: 'Maps'),
          PandaBarButtonData(
              id: 'Yellow', icon: Icons.perm_media, title: 'Media'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        onFabButtonPressed: () {
          setState(() {
            page = 'fab';
          });
        },
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'Grey':
              return Home();
            case 'Blue':
              return Calendar();
            case 'Red':
              return FullMap();
            case 'Yellow':
              return Media();
            case 'fab':
              return Qibla();
            default:
              return Container(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
