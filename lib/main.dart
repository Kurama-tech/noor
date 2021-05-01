// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noor/views/counterView.dart';
import 'package:noor/views/homeView.dart';
import 'package:provider/provider.dart';
import 'package:noor/provider/timingsProvider.dart';

import 'package:noor/views/counterView.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TimingsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationSet(),
        ),
        ChangeNotifierProvider(
          create: (_) => BooksProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => QuotesProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => VideosProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => PhotoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MapsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHomePage(),
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
          textTheme: TextTheme(headline4: TextStyle(color: Colors.black)),
          appBarTheme:
              AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),
        ));
  }
}
