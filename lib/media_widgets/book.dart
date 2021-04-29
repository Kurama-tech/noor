import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noor/model/books.dart';
import 'package:http/http.dart' as http;
import 'package:noor/provider/timingsProvider.dart';
import 'package:noor/views/pdfViewer.dart';
import 'package:provider/provider.dart';

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
    final booksModel = Provider.of<BooksProvider>(context, listen: false);
    //books_data = fetchBooks();
    if (!booksModel.flag) {
      booksModel.setdata();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final booksModel = Provider.of<BooksProvider>(context);
    return Center(
        child: !booksModel.flag
            ? Container(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: booksModel.booksData.length,
                itemBuilder: (context, i) {
                  final datalist = booksModel.booksData[i];
                  return Container(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
                    height: 100,
                    width: double.maxFinite,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Pdfview(pdf: datalist.url)));
                      },
                      child: Card(
                        elevation: 5,
                        child:Center(
                        child: ListTile(
                      leading: Icon(Icons.menu_book, size: 35.0),
                      title: Text(datalist.name,
                      style: TextStyle(fontSize: 17.0),
                      
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                        /* child: Center(
                        child: RichText(
                          text: TextSpan(
                            
                            text: datalist.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20), */
                        /* child: Column(
                          
                          children: [
                            Text(datalist.identifier),
                            Text(datalist.name),
                            Text(datalist.url)
                          ],
                        ), */
                      ),
                    ),
                    

                    ),
                    ),
                  );
                }));
  }
}
