import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noor/model/photos.dart';
import 'package:noor/provider/timingsProvider.dart';
import 'package:provider/provider.dart';
import 'package:noor/views/imagedetails.dart';

class Photo extends StatefulWidget {
  Photo({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build metrhod of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Photo createState() => _Photo();
}

class _Photo extends State<Photo> {
  Future<List<Photos>> photo_data;

  @override
  void initState() {
    final photoModel = Provider.of<PhotoProvider>(context, listen: false);
    //photo_data = fetchphoto();
    if (!photoModel.flag) {
      photoModel.setdata();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final photoModel = Provider.of<PhotoProvider>(context);
    return Center(
        child: !photoModel.flag
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
                  final datalist = photoModel.photos[i];
                  //return Image.network(datalist.url);
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
