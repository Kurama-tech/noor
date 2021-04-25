import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:noor/provider/count.dart';
import 'package:noor/views/counterView.dart';
import 'package:provider/provider.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:pandabar/main.view.dart';
import 'package:pandabar/pandabar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({key}) : super(key: key);
  static const title = "Noor-e-Mehdavia";

  get page => null;
   

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
      extendBodyBehindAppBar: false,
     /*  body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('${context.watch<Counter>().getCounter}')]),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: () =>
            Provider.of<Counter>(context, listen: false).incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), */

      bottomNavigationBar: PandaBar(
        buttonData: [
          PandaBarButtonData(
            id: 'Grey',
            icon: Icons.dashboard,
            title: 'Grey'
          ),
          PandaBarButtonData(
            id: 'Blue',
            icon: Icons.book,
            title: 'Blue'
          ),
          PandaBarButtonData(
            id: 'Red',
            icon: Icons.account_balance_wallet,
            title: 'Red'
          ),
          PandaBarButtonData(
            id: 'Yellow',
            icon: Icons.notifications,
            title: 'Yellow'
          ),
        ],
        onChange: (id) {
          setState(() {
                     var page = id;
                    });
                  },
                  onFabButtonPressed: () {
          
                  },
                ),
                body: Builder(
                  builder: (context) {
          
                    switch (page) {
                      case 'Grey':
                        return Container(color: Colors.grey.shade900);
                      case 'Blue':
                        return Container(color: Colors.blue.shade900);
                      case 'Red':
                        return Container(color: Colors.red.shade900);
                      case 'Yellow':
                        return Container(color: Colors.yellow.shade700);
                      default:
                        return Container();
                        
                    }
          
                  },
                ),
              
              );
            }
          }
          
          void setState(Null Function() param0) {
}


