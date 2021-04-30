import 'package:flutter/material.dart';
import 'package:noor/model/videos.dart';
import 'package:noor/provider/timingsProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final videosModel = Provider.of<VideosProvider>(context);
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
                    height: 100,
                    child: InkWell(
                      child: Card(
                        elevation: 5,
                        child: Center(
                          child: ListTile(
                            leading: Icon(Icons.video_label, size: 35.0),
                            title: Text(
                              datalist.name,
                              style: TextStyle(fontSize: 15.0),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right),

                            /* child: Center(
                        child: RichText(
                          text: TextSpan(
                            
                            text: datalist.name,
                            style: TextStyle(
                   color: Colors.grey,
                   fontSize: 15,
                   fontWeight: FontWeight.bold)), */
                            /*  child: Column(
                        children: [
                          Text(datalist.identifier),
                          Text(datalist.name),
                          Text(datalist.url)
                        ],
                      ), */
                          ),
                        ),
                      ),
                      onTap: () async {
                            await canLaunch(datalist.url)
                            ? await launch(datalist.url): throw 'Could not launch $datalist.url';
                      },
                    ),
                  );
                }));
  }
}
