// receipt data 한줄에 대한 클래스 정의
import 'package:flutter/material.dart';
import 'package:small_biz/ReceiptTextLines.dart';

enum Business { kchefs, kcleaners }

enum Retailer {
  ingredient,
  pertrol,
  car_repair,
  car_insurance,
  registration,
  gov,
  accounting,
  margeting,
  drink,
  packing,
  office,
  general_expanse,
  cleaning_chemical,
  fix_reno,
  material,
  tools,
  equipment,
  marketing,
  electricity,
  gas,
  rent,
  restraurant_insurence,
  cleaning_insurence,
  wage,
  super_,
  training_fund,
  work_cover,
  sa_water,
  phone,
  bank_fee,
  security_fire,
  contract
}

enum ReceiptDataType {
  business,
  date,
  retailer,
  retailer_01,
  gross,
  net,
  total,
  gst,
  details_01,
  details_02,
  image,
  text,
  count
}

class ReceiptDataHelper {
  var visibles = new Map();
  var titles = new Map();

  bool isVisible(ReceiptDataType type) {
    return visibles[type.toString()];
  }

  String getTitle(ReceiptDataType type) {
    return titles[type.toString()];
  }

  ReceiptDataHelper() {
    visibles[ReceiptDataType.business.toString()] = false;
    visibles[ReceiptDataType.date.toString()] = true;
    visibles[ReceiptDataType.retailer.toString()] = true;
    visibles[ReceiptDataType.retailer_01.toString()] = false;
    visibles[ReceiptDataType.gross.toString()] = false;
    visibles[ReceiptDataType.net.toString()] = false;
    visibles[ReceiptDataType.total.toString()] = true;
    visibles[ReceiptDataType.gst.toString()] = true;
    visibles[ReceiptDataType.details_01.toString()] = true;
    visibles[ReceiptDataType.details_02.toString()] = false;
    visibles[ReceiptDataType.image.toString()] = false;
    visibles[ReceiptDataType.text.toString()] = false;

    titles[ReceiptDataType.business.toString()] = 'Business';
    titles[ReceiptDataType.date.toString()] = 'Date';
    titles[ReceiptDataType.retailer.toString()] = 'Retailer';
    titles[ReceiptDataType.retailer_01.toString()] = 'Retailer_01';
    titles[ReceiptDataType.gross.toString()] = 'Gross';
    titles[ReceiptDataType.net.toString()] = 'Net';
    titles[ReceiptDataType.total.toString()] = 'Total';
    titles[ReceiptDataType.gst.toString()] = 'GST';
    titles[ReceiptDataType.details_01.toString()] = 'Details_01';
    titles[ReceiptDataType.details_02.toString()] = 'Details_02';
    titles[ReceiptDataType.image.toString()] = 'Image';
    titles[ReceiptDataType.text.toString()] = 'Text';
  }
}

class ReceiptData {
  ReceiptData() {
    this.business = Business.kchefs;
    this.date = DateTime.now();
    this.retailer = Retailer.accounting;
    this.retailer2 = 'Retailer2';
    this.gross = 10.0;
    this.net = 1;
    this.total = 2.52;
    this.gst = 10;
    this.details_01 = 'details 01';
    this.details_02 = 'details 02';
  }

  // ReceiptData({this._business, this._date, this._retailer, this._retailer2, this._gross, this._net, this._details_01, this._details_02, this._image, this._text});

  Business business;
  DateTime date;
  Retailer retailer;
  String retailer2;
  double gross;
  int net;
  double total;
  double gst;
  String details_01;
  String details_02;
  Image image;
  String text;

  getValue(ReceiptDataType type) {
    switch (type) {
      case ReceiptDataType.business:
        return business;
        break;
      case ReceiptDataType.date:
        return date;
        break;
      case ReceiptDataType.retailer:
        return retailer;
        break;
      case ReceiptDataType.retailer_01:
        return retailer2;
        break;
      case ReceiptDataType.gross:
        return gross;
        break;
      case ReceiptDataType.net:
        return net;
        break;
      case ReceiptDataType.gst:
        return gst;
        break;

      case ReceiptDataType.total:
        return total;
        break;
      case ReceiptDataType.details_01:
        return details_01;
        break;
      case ReceiptDataType.details_02:
        return details_02;
        break;
      case ReceiptDataType.image:
        return image;
        break;
      case ReceiptDataType.text:
        return text;
        break;
      default:
    }
  }

  // receipt text line으로 receipt data를 채운다.
  void setFromReceiptTextLines(ReceiptTextLines receiptTextLines) {
   
  }
}
