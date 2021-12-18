import 'package:flutter/material.dart';

class ViewImage extends StatefulWidget {
  final String image;
  const ViewImage({Key? key, required this.image}) : super(key: key);

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Center(
          child: Image.network(
            widget.image,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
