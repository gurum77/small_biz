import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:intl/intl.dart';

// vision text를 receipt data로 변환한다.
class VisionTextParser {
  DateTime _deliveryDate;

  VisionTextParser(VisionText vt) {
    _deliveryDate = GetDeliveryDate(vt);
  }

// deviverydate 찾기
  DateTime GetDeliveryDate(VisionText vt) {
    TextLine tl = FindTextLineIncludeText(vt, "Delivery Date");

    return GetDateTimeByText(tl.text);
  }

// text를 포함한 textline을 찾아서 리턴
  TextLine FindTextLineIncludeText(VisionText visionText, String text) {
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        if (line.text.contains(text)) return line;
      }
    }
    return null;
  }

// text에서 date time을 추출한다.
  DateTime GetDateTimeByText(String text) {
    // 7/05/2020 형식인지?
    List<String> strings = text.split('/');
  }
}
