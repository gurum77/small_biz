// 영수증용 text line들
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ReceiptTextLine {
  List<TextElement> elements = List<TextElement>();

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    for (var ele in elements) {
      stringBuffer.write(ele.text);
      if (ele != elements.last) {
        stringBuffer.write(' ');
      }
    }

    return stringBuffer.toString();
  }

  double getCenterY()
  {
    if(elements.length == 0)
    return 9999;

    return elements[0].boundingBox.center.dy;
  }
}

class ReceiptTextLines {
  List<ReceiptTextLine> lines = List<ReceiptTextLine>();

  void sort()
  {
    lines.sort((a,b)=>a.getCenterY() < b.getCenterY() ? -1 : (a.getCenterY() == b.getCenterY() ? 0 : 1));
  }

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    for(var line in lines)
    {
      stringBuffer.writeln(line.toString());
    }

    return stringBuffer.toString();
  }
}
