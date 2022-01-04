// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lokwani/widgets/widgets.dart';

var ad;

List ads = [];
List<dynamic> data = [];
List<dynamic> generalNews = [];
List<Widget> imageSliders = [];
List<dynamic> latestnews = [];
List<Widget> tabs = [];
List<Widget> tabview = [];

class General extends StatefulWidget {
  final ScrollController _scrollController;
  final dynamic id;

  const General({
    Key? key,
    required ScrollController scrollController,
    this.id,
  })  : _scrollController = scrollController,
        super(key: key);

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  var news = [];
  getNews(var id) async {
    var url = 'https://admin.lokwani.in/api/latest-rss-feeds?category_id=$id';
    // print(url);
    var res = await http.get(
      Uri.parse(url),
    );
    // print(res);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      news = data['data'];
      // print(news);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNews(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget._scrollController,
      child: Column(
        children: [
          ListView.builder(
            physics:
                const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
            shrinkWrap: true,
            itemCount: news.length,
            itemBuilder: (_, index) {
              return BigNewsCard(
                image: news[index]['image'].toString(),
                heading: news[index]['title'].toString(),
                time: news[index]['createTime'].toString(),
                date: news[index]['createDate'].toString(),
                title: news[index]['categoryName'].toString(),
                data: news[index],
                webview: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class Lokwani extends StatelessWidget {
  final ScrollController _scrollController;

  final List<Widget> imageSliders;
  const Lokwani({
    Key? key,
    required ScrollController scrollController,
    required this.imageSliders,
  })  : _scrollController = scrollController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
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
          ListView.builder(
            physics:
                const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
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
                webview: false,
              );
            },
          ),
          ListView.builder(
            physics:
                const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
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
            physics:
                const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
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
                webview: false,
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
            physics:
                const ScrollPhysics().applyTo(const BouncingScrollPhysics()),
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
                webview: false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  @override
  Widget build(BuildContext context) {
    final List<dynamic> imgList = ads;
    imageSliders = imgList
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return latestnews.isNotEmpty
        ? DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                toolbarHeight: 5,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  tabs: tabs,
                ),
              ),
              body: TabBarView(
                children: tabview,
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    latestnews.clear();
    tabs.clear();
    tabview.clear();
    super.dispose();
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

  getCategories() async {
    var url = 'https://admin.lokwani.in/api/rsscategories';
    var response = await http.get(Uri.parse(url));
    Tab tab;
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      setState(() {
        data = json.decode(response.body);
      });
      tab = const Tab(
        text: 'LOKWANI',
      );
      tabs.add(tab);
      tabview.add(Lokwani(
          scrollController: _scrollController, imageSliders: imageSliders));
      for (var element in data) {
        tab = Tab(
          text: element['name'].toString().toUpperCase(),
        );
        tabs.add(tab);
        tabview.add(General(
          scrollController: _scrollController,
          id: element['id'],
        ));
      }
      // ignore: avoid_print
      print(data);
      return data;
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
}
