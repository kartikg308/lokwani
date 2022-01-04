// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokwani/screens/screens.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BigNewsCard extends StatelessWidget {
  final String image;
  final String heading;
  final String time;
  final String date;
  final String title;
  final data;
  final webview;

  const BigNewsCard({
    Key? key,
    required this.image,
    required this.heading,
    required this.time,
    required this.date,
    required this.title,
    this.data,
    required this.webview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (webview == false) {
          Get.to(
            () => News(
              image: image,
              date: date,
              time: time,
              heading: heading,
              title: title,
              data: data,
            ),
          );
        } else {
          try {
            Get.to(
              () => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red,
                ),
                body: WebView(
                  initialUrl: data['link'],
                ),
              ),
            );
          } on Exception catch (e) {
            if (kDebugMode) {
              print(e);
            }
            Get.snackbar('Error', 'Some Exception Occurred');
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                height: 130,
                width: double.infinity,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.none,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red[400],
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  webview == false
                      ? Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date,
                                textScaleFactor: 1,
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                            const Icon(
                              Icons.timer_sharp,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                time,
                                textScaleFactor: 1,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Text(
                        heading,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        iconSize: 15,
                        icon: const Icon(Icons.share),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
