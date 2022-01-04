// ignore_for_file: sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokwani/screens/screens.dart';

class SmallNewsCard extends StatefulWidget {
  final String image;
  final String heading;
  final String time;
  final String date;
  final String title;
  final data;

  const SmallNewsCard({
    Key? key,
    required this.image,
    required this.heading,
    required this.time,
    required this.date,
    required this.title,
    this.data,
  }) : super(key: key);

  @override
  State<SmallNewsCard> createState() => _SmallNewsCardState();
}

class _SmallNewsCardState extends State<SmallNewsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(
            () => News(
              image: widget.image,
              date: widget.date,
              time: widget.time,
              heading: widget.heading,
              title: widget.title,
              data: widget.data,
            ),
            preventDuplicates: false,
          ).printError();
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: Row(
            children: [
              Container(
                height: 140,
                width: 140,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 185,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.heading,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.date_range,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            widget.date,
                            textScaleFactor: 1,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                        const Icon(
                          Icons.timer_sharp,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            widget.time,
                            textScaleFactor: 1,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
