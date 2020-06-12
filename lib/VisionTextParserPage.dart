import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisionTextParserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Parser',
        home: Scaffold(
            appBar: AppBar(
              title: Text('parser'),
            ),
            body: RaisedButton(
              onPressed: () {
                File visionText = File('visionText2.txt');
                List<String> lines = visionText.readAsLinesSync();
                print(lines);
              },
              child: Text('parse'),
            )));
  }
}
