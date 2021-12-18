// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:lokwani/widgets/smallnews.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  final String image;
  final String date;
  final String time;
  final String heading;
  final String title;
  final data;
  const News({
    Key? key,
    required this.image,
    required this.date,
    required this.time,
    required this.heading,
    this.data,
    required this.title,
  }) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  int page = 1;
  List<dynamic> generalNews = [];
  final ScrollController _scrollController = ScrollController();

  generalnews(int page) async {
    var url = 'https://admin.lokwani.in/api/general-news?page=$page';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data;
      // If the call to the server was successful, parse the JSON
      data = json.decode(response.body);
      // ignore: avoid_print
      print(data);
      setState(() {
        generalNews.addAll(data['data']['data']);
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
    var newsdata = parse(widget.data['description']).body!.text;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.red,
      //   excludeHeaderSemantics: true,
      // ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.image,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ]),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         padding: const EdgeInsets.all(8.0),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.red[400],
            //         ),
            //         child: Text(
            //           widget.title,
            //           style: const TextStyle(
            //             fontSize: 14,
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Row(
            //       children: [
            //         const Icon(Icons.date_range),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(widget.date),
            //         ),
            //         const Icon(Icons.timer_sharp),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(widget.time),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.heading,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // widget.data['description'],
                newsdata,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bhilwara Lokwani - ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Liked this article? Share it now!",
                    style: TextStyle(
                      fontSize: 20,
                      // color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 100,
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            "Share Now",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                    endIndent: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: NativeAds(),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  height: 40,
                  width: 10,
                  color: Colors.red,
                ),
                title: const Text(
                  'Related News',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // SmallNewsCard(
            //   image: latestnews[0]['featured_image'],
            //   heading: latestnews[0]['title'],
            //   time: latestnews[0]['createTime'],
            //   date: latestnews[0]['createDate'],
            //   title: latestnews[0]['categoryName'],
            //   data: latestnews[0],
            // ),
            // SmallNewsCard(
            //   image: latestnews[1]['featured_image'],
            //   heading: latestnews[1]['title'],
            //   time: latestnews[1]['createTime'],
            //   date: latestnews[1]['createDate'],
            //   title: latestnews[1]['categoryName'],
            //   data: latestnews[1],
            // ),
            // SmallNewsCard(
            //   image: latestnews[2]['featured_image'],
            //   heading: latestnews[2]['title'],
            //   time: latestnews[2]['createTime'],
            //   date: latestnews[2]['createDate'],
            //   title: latestnews[2]['categoryName'],
            //   data: latestnews[2],
            // ),
            // SmallNewsCard(
            //   image: latestnews[3]['featured_image'],
            //   heading: latestnews[3]['title'],
            //   time: latestnews[3]['createTime'],
            //   date: latestnews[3]['createDate'],
            //   title: latestnews[3]['categoryName'],
            //   data: latestnews[3],
            // ),
            ListView.builder(
              physics:
                  const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
              shrinkWrap: true,
              itemCount: generalNews.length,
              itemBuilder: (_, index) {
                return SmallNewsCard(
                  image: generalNews[index]['featured_image'],
                  heading: generalNews[index]['title'],
                  time: generalNews[index]['createTime'],
                  date: generalNews[index]['createDate'],
                  title: generalNews[index]['categoryName'],
                  data: generalNews[index],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          color: Colors.red,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'Back To Home Screen',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
