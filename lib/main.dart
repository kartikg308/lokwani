// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokwani/screens/home.dart';
import 'package:lokwani/screens/screens.dart' as screens;

import 'screens/gallery.dart';
// import 'package:native_admob_flutter/native_admob_flutter.dart';

void main() {
  // MobileAds.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  void _onTapHandler(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> widgets = <Widget>[
    const Home(),
    const screens.Video(),
    const screens.Directory(),
    // MyHomePage(title: 'Screen'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Lokwani',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const screens.Notification());
            },
            icon: Image.asset(
              'assets/carbon_notification-1.png',
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/carbon_play-outline-1.png',
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                child: const Center(
                  child: Text('Icon'),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Container(
                  height: 40,
                  width: 10,
                  color: Colors.red,
                ),
                title: const Text(
                  'Lokwani',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Container(
                  height: 40,
                  width: 10,
                  color: Colors.red,
                ),
                title: const Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Container(
                  height: 40,
                  width: 10,
                  color: Colors.red,
                ),
                title: const Text(
                  'Reporter Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(() => const Gallery());
                },
                leading: Container(
                  height: 40,
                  width: 10,
                  color: Colors.red,
                ),
                title: const Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Container(
                  height: 40,
                  width: 10,
                  color: Colors.red,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: widgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        onTap: _onTapHandler,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        // fixedColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/carbon_home.png',
            ),
            activeIcon: Image.asset(
              'assets/carbon_home-1.png',
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/carbon_screen.png',
            ),
            activeIcon: Image.asset(
              'assets/carbon_screen-1.png',
              colorBlendMode: BlendMode.darken,
            ),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/carbon_book.png',
            ),
            activeIcon: Image.asset(
              'assets/carbon_book-2.png',
            ),
            label: 'Directory',
          ),
        ],
      ),
    );
  }
}
