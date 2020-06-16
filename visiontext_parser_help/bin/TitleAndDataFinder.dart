import 'TextParser.dart' as textParser;

// 여러 타입의 제목과 데이타로 이루어진 문자열을 찾는다.
class TitleAndDataFinder {
  List<String> _textLines;

  TitleAndDataFinder(List<String> textLines) {
    _textLines = textLines;
  }

  // text를 포함하는 textline 찾기
  String findTextLineByIncludingText(String includingText) {
    var lcIncludingText = includingText.toLowerCase();
    for (var line in _textLines) {
      var lcLine = line.toLowerCase();
      if (lcLine.contains(lcIncludingText)) {
        return line;
      }
    }

    return null;
  }

  // text를 포함하는 가격 text line 찾기
  List<String> findAllPriceTextLinesByIncludingText(String includingText) {
    var lines = List<String>();

    var lcIncludingText = includingText.toLowerCase();
    for (var line in _textLines) {
      var lcLine = line.toLowerCase();

      if (lcLine.contains(lcIncludingText)) {
        // text를 포함하면 이것이 가격 text line인지 체크한다.
        if (textParser.splitPriceTitalAndValue(line) != null) {
          lines.add(line);
        }
      }
    }

    return lines;
  }
}
