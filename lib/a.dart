import 'package:flutter/material.dart';

void main() => runApp(GridDemo());

class GridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demo',
      home: Scaffold(
          appBar: AppBar(title: const Text('demo')),
          body: DataTable(columns: [
            DataColumn(label: Text('이름')),
            DataColumn(label: Text('출생년도'), numeric: true),
            DataColumn(label: Text('성별')),
            DataColumn(label: Text('최종학력')),
            DataColumn(label: Text('고향')),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('철수')),
              DataCell(Text('1977')),
              DataCell(Text('남')),
              DataCell(Text('학사')),
              DataCell(Text('부산')),
            ]),
            DataRow(cells: [
              DataCell(Text('영희')),
              DataCell(Text('1981')),
              DataCell(Text('여')),
              DataCell(Text('석사')),
              DataCell(Text('서울')),
            ])
          ])),
    );
  }
}
