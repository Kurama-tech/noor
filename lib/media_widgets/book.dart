import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noor/model/books.dart';
import 'package:http/http.dart' as http;


class Book extends StatefulWidget {
  Book({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build metrhod of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _Book createState() => _Book();
}

class _Book extends State<Book> {

  
  Future<List<Books>> books_data;

    @override
  void initState() {
    books_data = fetchBooks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder<List<Books>>(
            future: books_data,
            builder: (context, snapshot) {
              print(snapshot.toString());
              if (snapshot.hasData) {
               return ListView.builder(
                 itemCount: snapshot.data.length,
                 itemBuilder: (context,i){
                     final datalist = snapshot.data[i];
                     return Container(
                       child: Card(child: Column(children: [ Text(datalist.identifier), Text(datalist.name), Text(datalist.url)],),),
                     );
                 });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            }));
  }
}

Future<List<Books>> fetchBooks() async {
  var uri = Uri.https('api.nooremahdavia.com', "/media/book");
  List<Books> ListModel = [];
  print(uri);

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    //print(response.body.toString());
    final data = jsonDecode(response.body);
    
    for(Map i in data['results']){
      //print(i);
      ListModel.add(Books.fromJson(i));
    }
   return ListModel;
  } else {
    throw Exception('Failed to load Books');
  }
}
