import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_biz/ReceiptData.dart';

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
  final picker = ImagePicker();

  Future getImage(bool byCamera) async {
    final pickedFile = await picker.getImage(
        source: byCamera ? ImageSource.camera : ImageSource.gallery);

    setState(() {
      if (pickedFile == null)
        _image = null;
      else
        _image = File(pickedFile.path);
    });
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
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('images/sample_receipt.jpg'),
              //         fit: BoxFit.cover)),
              child: Column(
            children: <Widget>[
              DataTable(columns: [
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Value'), numeric: true)
              ], rows: this.rows),
            ],
          )),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: null,
          //   child: Icon(Icons.add),
          //   elevation: 20,
          // ),
        ));
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
}
