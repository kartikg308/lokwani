import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String title;
  final String artcles;

  const Category({
    Key? key,
    required this.title,
    required this.artcles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 80,
                color: Colors.white,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                artcles,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
