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
  var dts = DTS();
  ReceiptDataHelper receiptDataHelper = ReceiptDataHelper();
  List<DataColumn> columns = new List<DataColumn>();
  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;

  _TableInputPageState() {
    InitColumns();
  }

  void InitColumns() {
    ReceiptDataType.values.forEach((element) {
      if (element == ReceiptDataType.count) return;

      columns.add(DataColumn(label: Text(receiptDataHelper.getTitle(element))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Table Input',
        home: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
          child: PaginatedDataTable(
            header: Text('Data table hffeader'),
            columns: columns,
            source: dts,
            onRowsPerPageChanged: (r) {
              setState(() {
                _rowPerPage = r;
              });
            },
            rowsPerPage: _rowPerPage,
          ),
        ))));
  }
}

class DTS extends DataTableSource {
  List<ReceiptData> datas = new List<ReceiptData>();
  DTS() {
    datas.clear();
    for (int i = 0; i < 105; ++i) datas.add(new ReceiptData());
  }

  @override
  DataRow getRow(int index) {
    ReceiptData data = datas[index];
    List<DataCell> cells = new List<DataCell>();
    ReceiptDataType.values.forEach((element) {
      if (element == ReceiptDataType.count) return;
      cells.add(DataCell(Text(data.getValue(element).toString())));
    });

    return DataRow.byIndex(index: index, cells: cells);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => datas.length;

  @override
  int get selectedRowCount => 0;
}
