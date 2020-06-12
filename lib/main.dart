import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:small_biz/TableInputPage.dart';
import 'package:small_biz/VisionTextParser.dart';
import 'PhotoInputPage.dart';
import 'VisionTextParserPage.dart';

void main() {
  // runApp(MyApp());
  runApp(VisionTextParserPage());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Small-Biz',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text('Small-Biz receipt reader'),
                bottom: TabBar(
                    //isScrollable: true,
                    tabs: [
                      Tab(
                        text: 'Photo input',
                        icon: Icon(Icons.photo),
                      ),
                      Tab(
                        text: 'Table input',
                        icon: Icon(Icons.list),
                      ),
                      Tab(
                        text: 'Summary',
                        icon: Icon(Icons.library_books),
                      ),
                    ]),
              ),
              body: TabBarView(children: [
                PhotoInputPage(title: 'PhotoInput'),
                TableInputPage(title: 'TableInput'),
                PhotoInputPage(title: 'Summary'),
              ])),
        ));
  }
}
