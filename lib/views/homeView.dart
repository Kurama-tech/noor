import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pandabar/fab-button.view.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/pandabar.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class MyHomePage extends StatefulWidget {
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  static const title = "Noor-e-Mehdavia";

  var page = 'Blue';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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
      extendBodyBehindAppBar: true,
      bottomNavigationBar: PandaBar(
        fabIcon:  FaIcon(FontAwesomeIcons.kaaba),
        
        backgroundColor: Theme.of(context).primaryColor,
        buttonData: [
          PandaBarButtonData(id: 'Grey', icon: Icons.home, title: 'Home'),
          PandaBarButtonData(id: 'Blue', icon: Icons.calendar_today, title: 'Calender'),
          PandaBarButtonData(id: 'Red', icon: Icons.place, title: 'Maps'),
          PandaBarButtonData(id: 'Yellow', icon: Icons.perm_media, title: 'Media'),
         
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
              return Container(color: Colors.grey);
            case 'Blue':
              return Container(color: Colors.blue.shade900);
            case 'Red':
              return Container(color: Colors.red.shade900);
            case 'Yellow':
              return Container(color: Colors.yellow.shade700);
            case 'fab':
              return Container(
                child: Text(
                  "Hello ",
                  style: TextStyle(color: Colors.black),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
