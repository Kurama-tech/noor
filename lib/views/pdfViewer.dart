import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';


class Pdfview extends StatefulWidget {
  Pdfview({key, this.pdf}) : super(key: key);

  final String pdf;
  @override
  PdfViewState createState() => PdfViewState();
}
class PdfViewState extends State<Pdfview> {
  PDFDocument document;
  bool _isLoading = true;

  @override
   void initState() {
    super.initState();
    loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,)
    )
    );
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(this.widget.pdf);

    setState(() => _isLoading = false);
  }
}
