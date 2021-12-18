// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lokwani/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<dynamic> data = [];
var ad;
List ads = [];
List<dynamic> latestnews = [];
List<dynamic> generalNews = [];

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  getCategories() async {
    var url = 'https://admin.lokwani.in/api/rsscategories';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      setState(() {
        data = json.decode(response.body);
      });
      // ignore: avoid_print
      print(data);
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  getad() async {
    var url = 'https://admin.lokwani.in/api/advertisements';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      ad = json.decode(response.body);
      // ignore: avoid_print
      print(ad);
      for (var i = 0; i < ad['total']; i++) {
        var ad1;
        var url = 'https://admin.lokwani.in/api/advertisements';
        var response = await http.get(Uri.parse(url));
        ad1 = json.decode(response.body);
        setState(() {
          ads.add(ad1['data'][0]['image']);
        });
        // print(ads);
      }
      return ad;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  getlatestnew() async {
    var url = 'http://admin.lokwani.in/api/latestrandomnews';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data;
      // If the call to the server was successful, parse the JSON
      data = json.decode(response.body);
      // ignore: avoid_print
      print(data);
      setState(() {
        latestnews = data;
      });
      // print('latestnews' * 50);
      // print(latestnews);
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

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
    getCategories();
    getad();
    getlatestnew();
    generalnews(1);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // OKToast(
        //   child: Container(
        //     height: 50,
        //     width: 50,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: CircularProgressIndicator(
        //             color: Colors.white,
        //           ),
        //         ),
        //         const Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             'Loading...',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   backgroundColor: Colors.red,
        //   duration: const Duration(seconds: 2),
        // );
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
              children: [
                const Text('Loading...'),
                const CircularProgressIndicator(),
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
    latestnews.clear();
    super.dispose();
  }

  // dynamicTabs() {
  //   return data.map((item) {
  //     return Tab(
  //       child: Text(item['name']),
  //     );
  //   }).toList();
  // }

  // dynamicTabBar() {
  //   return const TabBar(
  //     indicatorColor: Colors.white,
  //     labelColor: Colors.white,
  //     unselectedLabelColor: Colors.white,
  //     tabs: [
  //       Tab(
  //         child: Text(
  //           'Latest',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //       Tab(
  //         child: Text(
  //           'Popular',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //       Tab(
  //         child: Text(
  //           'Categories',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> imgList = ads;
    final List<Widget> imageSliders = imgList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      // child: Text(
                      //   'No. ${imgList.indexOf(item)} image',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 20.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return latestnews.isNotEmpty
        ? SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Lokwani',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '${data[0]['name']}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '${data[1]['name']}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '${data[2]['name']}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '${data[3]['name']}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     '${data[4]['name']}',
                        //     style: const TextStyle(
                        //       color: Colors.red,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     '${data[5]['name']}',
                        //     style: const TextStyle(
                        //       color: Colors.red,
                        //       fontSize: 20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ads.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            viewportFraction: 0.9,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          items: imageSliders,
                        )
                      : Container(),
                ),
                // Text(
                //   'Latest News ${latestnews.length}',
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                ListView.builder(
                  physics: const ScrollPhysics()
                      .applyTo(const BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return BigNewsCard(
                      image: latestnews[index]['featured_image'],
                      heading: latestnews[index]['title'],
                      time: latestnews[index]['createTime'],
                      date: latestnews[index]['createDate'],
                      title: latestnews[index]['categoryName'],
                      data: latestnews[index],
                    );
                  },
                ),
                ListView.builder(
                  physics: const ScrollPhysics()
                      .applyTo(const BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return SmallNewsCard(
                      image: latestnews[index + 3]['featured_image'],
                      heading: latestnews[index + 3]['title'],
                      time: latestnews[index + 3]['createTime'],
                      date: latestnews[index + 3]['createDate'],
                      title: latestnews[index + 3]['categoryName'],
                      data: latestnews[index + 3],
                    );
                  },
                ),
                ListView.builder(
                  physics: const ScrollPhysics()
                      .applyTo(const BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (_, index) {
                    return BigNewsCard(
                      image: latestnews[index + 7]['featured_image'],
                      heading: latestnews[index + 7]['title'],
                      time: latestnews[index + 7]['createTime'],
                      date: latestnews[index + 7]['createDate'],
                      title: latestnews[index + 7]['categoryName'],
                      data: latestnews[index + 7],
                    );
                  },
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Category(
                //           title: 'Rajasthan', artcles: '10 Articles'),
                //       const Category(title: 'Bhilwara', artcles: '89 Articles'),
                //       const Category(
                //           title: 'Mandalghar', artcles: '25 Articles'),
                //       const Category(title: 'Jahajpur', artcles: '87 Articles'),
                //     ],
                //   ),
                // ),
                ListView.builder(
                  physics: const ScrollPhysics()
                      .applyTo(const BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: generalNews.length,
                  itemBuilder: (_, index) {
                    return BigNewsCard(
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
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
  }
}
