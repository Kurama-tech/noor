import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  ImageDetails(this.image);

  final String image;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: new Image.network(
        image,
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
