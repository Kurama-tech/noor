import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noor/model/videos.dart';
import 'package:noor/provider/timingsProvider.dart';
import 'package:provider/provider.dart';

class Video extends StatefulWidget {
  Video({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build metrhod of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Video createState() => _Video();
}

class _Video extends State<Video> {
  Future<List<Videos>> video_data;

  @override
  void initState() {
    //video_data = fetchvideos();
    final videosModel = Provider.of<VideosProvider>(context, listen: false);
    if (!videosModel.flag) {
      videosModel.setdata();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final videosModel = Provider.of<VideosProvider>(context, listen: false);
    return Center(
        child: !videosModel.flag
            ? Container(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: videosModel.videos.length,
                itemBuilder: (context, i) {
                  final datalist = videosModel.videos[i];
                  return Container(
                    child: Card(
                      child: Column(
                        children: [
                          Text(datalist.identifier),
                          Text(datalist.name),
                          Text(datalist.url)
                        ],
                      ),
                    ),
                  );
                }));
  }
}
