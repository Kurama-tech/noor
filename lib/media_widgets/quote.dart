import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noor/model/quotes.dart';
import 'package:http/http.dart' as http;
import 'package:noor/provider/timingsProvider.dart';
import 'package:noor/views/imagedetails.dart';
import 'package:provider/provider.dart';

class Quote extends StatefulWidget {
  Quote({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build metrhod of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Quote createState() => _Quote();
}

class _Quote extends State<Quote> {

  @override
  void initState() {
    //quote_data = fetchQuotes();
    final quotesModel = Provider.of<QuotesProvider>(context, listen: false);
    if (!quotesModel.flag) {
      quotesModel.setdata();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quotesModel = Provider.of<QuotesProvider>(context);
    return Center(
        child: !quotesModel.flag
            ? Container(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, i) {
                  final datalist = quotesModel.quotes[i];
                  return InkWell(
                      child: Image.network(datalist.url),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ImageDetails(datalist.url)));
                      });
                }));
        
  }
}
