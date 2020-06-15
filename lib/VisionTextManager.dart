import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'ReceiptTextLines.dart';


// vision text 관리자
// vision text를 파싱하기 적당하게 제어한다.
class VisionTextManager {
  double _tol = 10; // 연결가능한 위 아래 오차범위

  // vision text에서 정리된 textline을 리턴한다.
  ReceiptTextLines findTextLinesByVisionText(VisionText visionText) {

    var receipttextLines = new ReceiptTextLines();

    // 모든 element를 가져온다.
    var elements = getAllTextElements(visionText);

    while (elements.length > 0) {
      // 가장 왼쪽에 있는 element를 하나 가져온다.
      var leftElement = pullLeftElement(elements);
      var textLine = new ReceiptTextLine();
      textLine.elements.add(leftElement);

      if(leftElement.text.contains('Product'))
      {
       int i= 0;
       i = 0; 
      }

      // 가장 왼쪽부터 연결가능한 가장 가까운 오른쪽 element를 가져온다.
      while (true) {
        // 연결할 수 있는 element를 가져온다.
        leftElement = pullConnectableElement(elements, leftElement);
        if (leftElement == null) break;

        // line에 추가
        textLine.elements.add(leftElement);
      }

      // 모두 찾았으면 line을 추가
      receipttextLines.lines.add(textLine);
    }

    // 정렬
    receipttextLines.sort();

    return receipttextLines;
  }

  // 모든 text elements를 가져온다.
  List<TextElement> getAllTextElements(VisionText visionText) {
    var words = List<TextElement>();
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          words.add(word);
        }
      }
    }
    return words;
  }

  // elements 중에서 가장 왼쪽에 있는 것을 리턴한다.
  // 찾은 것은 list에서 제외한다.
  TextElement pullLeftElement(List<TextElement> elements) {
    TextElement leftElement;

    for (int i = 0; i < elements.length; ++i) {
      TextElement ele = elements[i];
      if (leftElement == null ||
          leftElement.boundingBox.left > ele.boundingBox.left) {
        leftElement = ele;
      }
    }

    if (leftElement != null) elements.remove(leftElement);

    return leftElement;
  }

  // elements 중에서 leftElement에 연결될 수 있는 가장 왼쪽의 것을 리턴한다.
  // 찾은 것은 list에서 제외한다.
  TextElement pullConnectableElement(List<TextElement> elements, TextElement leftElement) {

    TextElement connectElement;
    for (var ele in elements) {
      if(leftElement.text.contains('Time') && ele.text.contains('PM'))
      {
        int i = 0;
        i = 0;
      }
      // 연결이 안되면 통과
      if (!isConnectable(leftElement, ele)) continue;
      
      // 연결되는 것 중에서 가장 왼쪽 것을 택한다.
      if(connectElement == null || connectElement.boundingBox.left > ele.boundingBox.left)
      {
        connectElement  = ele;
      }
    }

    if(connectElement != null)
    {
      elements.remove(connectElement);
    }

    return connectElement;
  }

  // 연결 가능한지 판단한다.
  bool isConnectable(TextElement leftElement, TextElement ele) {
    if (leftElement == null || ele == null) return false;

    // 위아래 오차 범위 내에 들어야 함.
    double diffY  = (leftElement.boundingBox.center.dy - ele.boundingBox.center.dy).abs();
    
    if ((leftElement.boundingBox.center.dy - ele.boundingBox.center.dy).abs() >
        _tol) return false;

    // 오른쪽에 있어야 함
    if (leftElement.boundingBox.right > ele.boundingBox.left) return false;

    return true;
  }
}
