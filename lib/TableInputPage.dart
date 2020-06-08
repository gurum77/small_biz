import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ReceiptData.dart';

class TableInputPage extends StatefulWidget {
  String title;

  TableInputPage({this.title});
  @override
  State<StatefulWidget> createState() {
    return _TableInputPageState();
  }
}

class _TableInputPageState extends State<TableInputPage> {
  _TableInputPageState() {
    InitColumns();
    InitRows();
  }

  void InitColumns() {
    ReceiptDataType.values.forEach((element) {
      if (element == ReceiptDataType.count) return;

      columns.add(DataColumn(label: Text(receiptDataHelper.getTitle(element))));
    });
  }

  void InitRows() {
    for (int i = 0; i < 100; ++i) datas.add(new ReceiptData());

    for (int i = 0; i < datas.length; ++i) {
      AddDataRowByData(rows, datas[i]);
    }
  }

  ReceiptDataHelper receiptDataHelper = ReceiptDataHelper();
  List<ReceiptData> datas = new List<ReceiptData>();
  List<DataRow> rows = new List<DataRow>();
  List<DataColumn> columns = new List<DataColumn>();

  void AddDataRowByData(List<DataRow> rows, ReceiptData data) {
    List<DataCell> cells = new List<DataCell>();
    ReceiptDataType.values.forEach((element) {
      if (element == ReceiptDataType.count) return;
      cells.add(DataCell(Text(data.getValue(element).toString())));
    });

    rows.add(new DataRow(cells: cells));
  }

  //  void AddDataRow(List<DataRow> rows, ReceiptData data) {
  //   if (!receiptDataHelper.isVisible(type)) return;

  //   rows.add(new DataRow(cells: [
  //     DataCell(Text(receiptDataHelper.getTitle(type))),
  //     DataCell(Text(receiptData.getValue(type).toString()))
  //   ]));
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Table Input',
        home:
            Scaffold(body: DataTable(columns: this.columns, rows: this.rows)));
  }
}
