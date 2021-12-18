import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lokwani/screens/viewimage.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int page = 1;
  List<dynamic>? images = [];
  final ScrollController _scrollController = ScrollController();

  generalnews(int page) async {
    var url = 'https://admin.lokwani.in/api/gallery-images?page=$page';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // ignore: prefer_typing_uninitialized_variables
      var data;
      // If the call to the server was successful, parse the JSON
      data = json.decode(response.body);
      // ignore: avoid_print
      print(data);
      setState(() {
        images!.addAll(data['data']['data']);
      });
      // print('generalnews' * 50);
      // print(generalnews);
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    generalnews(1);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: 200,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Loading...'),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
        setState(() {
          page = page + 1;
        });
        generalnews(page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: images!.isNotEmpty
          ? GridView.builder(
              controller: _scrollController,
              itemCount: images?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => ViewImage(
                        image: 'https://admin.lokwani.in/' +
                            images![index]['img_path'],
                      ),
                    );
                  },
                  child: Image.network(
                    'https://admin.lokwani.in/' + images![index]['img_path'],
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
    );
  }
}
