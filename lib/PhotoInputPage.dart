import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_biz/ReceiptData.dart';
import 'package:small_biz/VisionTextManager.dart';
import 'ReceiptTextLines.dart';

class PhotoInputPage extends StatefulWidget {
  String title;

  PhotoInputPage({this.title});

  @override
  State<StatefulWidget> createState() {
    return _PhotoInputPageState();
  }
}

class _PhotoInputPageState extends State<PhotoInputPage> {
  ReceiptDataHelper receiptDataHelper = ReceiptDataHelper();
  ReceiptData receiptData = ReceiptData();
  List<DataRow> rows = new List<DataRow>();
  File _image;
  VisionText visionText;
  final picker = ImagePicker();

  Future getImage(bool byCamera) async {
    final pickedFile = await picker.getImage(
        source: byCamera ? ImageSource.camera : ImageSource.gallery);

    if (pickedFile == null)
      _image = null;
    else {
      _image = File(pickedFile.path);
      // 영수증 사진을 가져오면 이을 분석해서 영수증 데이타로 변환한다.
      FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_image);
      TextRecognizer textReader = FirebaseVision.instance.cloudTextRecognizer();

      visionText = await textReader.processImage(visionImage);

      var visionTextManager = VisionTextManager();
      var receiptTextLines =
          visionTextManager.findTextLinesByVisionText(visionText);

      rows.clear();
      int num = 1;
      for (var textLine in receiptTextLines.lines) {
        rows.add(DataRow(cells: [
          DataCell(Text(num.toString())),
          DataCell(Text(textLine.toString()))
        ]));
        num++;
      }

      // for (TextBlock block in visionText.blocks) {
      //   // print(block.text);
      //   for (TextLine line in block.lines) {
      //     // print(line.text);

      //     for (TextElement word in line.elements) {
      //       print(word.text);
      //     }
      //   }
      // }
      setState(() {});
    }
  }

  void AddDataRow(List<DataRow> rows, ReceiptDataType type) {
    if (!receiptDataHelper.isVisible(type)) return;

    rows.add(new DataRow(cells: [
      DataCell(Text(receiptDataHelper.getTitle(type))),
      DataCell(Text(receiptData.getValue(type).toString()))
    ]));
  }

  InitRows() {
    AddDataRow(rows, ReceiptDataType.business);
    AddDataRow(rows, ReceiptDataType.date);
    AddDataRow(rows, ReceiptDataType.retailer);
    AddDataRow(rows, ReceiptDataType.retailer_01);
    AddDataRow(rows, ReceiptDataType.gross);
    AddDataRow(rows, ReceiptDataType.net);
    AddDataRow(rows, ReceiptDataType.total);
    AddDataRow(rows, ReceiptDataType.gst);
    AddDataRow(rows, ReceiptDataType.details_01);
    AddDataRow(rows, ReceiptDataType.details_02);
    AddDataRow(rows, ReceiptDataType.image);
    AddDataRow(rows, ReceiptDataType.text);
  }

  _PhotoInputPageState() {
    InitRows();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PhotoInput',
        home: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.skip_previous), title: Text('Prev.')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.save), title: Text('Save')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.skip_next), title: Text('Next')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.space_bar), title: Text('')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add), title: Text('New')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.photo), title: Text('Photo')),
                  // BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('Add')),
                ]),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: _image == null
                          ? AssetImage('images/sample_receipt.jpg')
                          : FileImage(_image),
                      fit: BoxFit.cover)),
              child: Container(
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(20),
                  color: Color.fromARGB(240, 255, 255, 0), child: buildFutureBuilderListView()),
            )

            // floatingActionButton: FloatingActionButton(
            //   onPressed: null,
            //   child: Icon(Icons.add),
            //   elevation: 20,
            // ),
            ));
  }

  FutureBuilder<List<DataRow>> buildFutureBuilderListView() {
    return FutureBuilder(
      future: getRows(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemBuilder: (context, position) {
            List<DataRow> rows = snapshot.data;
            if (position < rows.length) {
              DataRow dataRow = rows[position];
              return Row(
                children: <Widget>[
                  Container(child: dataRow.cells[0].child),
                  SizedBox(width: 10,),
                  Container(child: dataRow.cells[1].child)
                ],
              );
            }
          });
        }
      },
    );
  }

  DataTable buildDataTable() {
    return DataTable(columns: [
      DataColumn(label: Text('Title')),
      DataColumn(label: Text('Value'), numeric: true)
    ], rows: this.rows);
  }

  void _onItemTapped(int value) {
    if (value == 4) {
      // camera
      getImage(true);
    } else if (value == 5) {
      // gallery
      getImage(false);
    }
  }

  Future<List<DataRow>> getRows() async {
    return rows;
  }
}
