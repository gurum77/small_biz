import 'dart:io';
import 'ReceiptDataParser.dart';

void main() {
  // vision text 파일을 읽는다.
  var file = File('visiontext1.txt');
  var textlines = file.readAsLinesSync();

// 변환한다
  var parser = ReceiptDataParser(textlines);
  print(parser.toString());
}

// firstmatch와 all matches를 출력하는 함수입니다.
// 정규식을 적용한 결과를 이쁘게 보여주기 위한 함수입니다.
void PrintResult(
    String source, String regexPattern, var firstMatch, var allMatches) {
  print('\nSource : $source');
  print('정규식 : ${regexPattern}');
  PrintMatch('first match', firstMatch);
  if (allMatches == null || allMatches.length == 0) {
    print(' all matches -> null');
  } else {
    for (var match in allMatches) {
      PrintMatch('all matches', match);
    }
  }
}

// 정규식에는 일치하는 문자열의 인덱스 정보(start, end)가 있습니다.
// 이걸 이용해서 결과를 출력하는 함수입니다.
void PrintMatch(String title, RegExpMatch regExpMatch) {
  if (regExpMatch == null) {
    print('$title -> null');
  } else {
    print(
        '$title -> start : ${regExpMatch.start}, end : ${regExpMatch.end}, string : ${regExpMatch.input.substring(regExpMatch.start, regExpMatch.end)}');
  }
}
