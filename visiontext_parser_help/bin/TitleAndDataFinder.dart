class TitleAndDataFinder {
  List<String> _textLines;
  String _title;
  String _data;

  TitleAndDataFinder(List<String> textLines) {
    _textLines = textLines;
  }

  // text를 포함하는 textline 찾기
  String FindTextLineByIncludingText(String includingText) {
    String lcIncludingText = includingText.toLowerCase();
    for (var line in _textLines) {
      var lcLine = line.toLowerCase();
      if (lcLine.contains(includingText)) {
        return line;
      }
    }

    return null;
  }
}
