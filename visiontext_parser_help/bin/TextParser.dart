import 'dart:convert';
import 'dart:mirrors';

import 'TextParserResult.dart';

// text가 0~9 인 숫자로 이루어 졌는지 판단한다.
bool isDigit(String text) {
  var reg = RegExp(r'\d+');

  var firstMatch = reg.firstMatch(text);
  if (firstMatch == null) return false;

  if (firstMatch.end - firstMatch.start < text.length) return false;

  return true;
}

// text를 datetime으로 변환해서 리턴한다
DateTime textToDateTime(String text) {
  // 구분자 : / -
  // 구분자로 나눴을때 3개의 단어가 나와야 한다.
  var reg = RegExp(r'[/-]');
  var allMatches = reg.allMatches(text);
  if (allMatches == null) return null;
  if (allMatches.length != 2) return null;

  // 구분자를 사이에 두고 추출
  List<String> texts = text.split(reg);

  if (texts == null || texts.length != 3) return null;

  // 첫번째와 마지막은 day 아니면 year이다.
  // 무조건 숫자 이어야 한다
  if (!isDigit(texts[0]) || !isDigit(texts[2])) return null;

  int yyyy, mm, dd;

  // 앞의 숫자가 더 크면 yyyy mm dd 순이고
  // 뒤의 숫자가 더 크면 dd mm yyyy 순이다.
  int num1 = int.parse(texts[0]);
  int num3 = int.parse(texts[2]);
  if (num1 > num3) {
    yyyy = num1;
    dd = num3;
  } else {
    dd = num1;
    yyyy = num3;
  }

  if (yyyy < 1000) {
    yyyy += 2000;
  }

  // mm은 영어일수도 있고, 숫자 일 수도 있다
  mm = textToMonth(texts[1]);

  return DateTime(yyyy, mm, dd);
}

// text를 price로 변환
// 맨 앞이나 맨 뒤에 있는 화폐단위를 빼고 변환한다.
double textToPrice(String text) {
  // 화폐단위를 모두 제거한다.
  var reg = RegExp(r'[\$]');
  text = text.replaceAll(reg, '');

  return double.parse(text);
}

// text를 month로 변경
int textToMonth(String text) {
  if (isDigit(text)) return int.parse(text);

  String lowerCaseText = text.toLowerCase();

  var monList = [
    'jan',
    'feb',
    'may',
    'apr',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  for (int i = 0; i < monList.length; ++i) {
    if (lowerCaseText.contains(monList[i])) return i + 1;
  }

  return 0;
}

// 가격이 포함된 text를 title과 value로 구분한다.
// 가격이 포함된 text는 마지막에 숫자와 나머지로 구분한다.
TitleAndValueResult splitPriceTitalAndValue(String text) {
  // $와 숫자가 있고 text의 끝에 붙어 있으면 price이다.
  var reg = RegExp(r'\$[\d\.]*');
  var allMatches = reg.allMatches(text);
  if (allMatches != null &&
      allMatches.length > 0 &&
      allMatches.last.end == text.length) {
    var value = text.substring(allMatches.last.start, allMatches.last.end);

    var re = TitleAndValueResult();
    re.title = text.substring(0, allMatches.last.start); // 가격이전까지는 모두 title로 사용
    re.title.trimRight(); // 우측 공백 제거
    re.value = value;
    return re;
  }

  // 없다면 그냥 숫자가 마지막에 붙어 있으면 price이다.
  // TODO : 숫자만 있는 경우에 대해서 코딩해야함
  return null;
}

// text를 title과 value로 구분한다.
TitleAndValueResult splitTitleAndValue(String text) {
  {
    var reg = RegExp(r'[:]');

    // 구분자 : = - :
    var allMatches = reg.allMatches(text);

    // 구분자가 1개만 있어야 한다.
    if (allMatches == null) return null;
    if (allMatches.length != 1) return null;
  }

  var re = TitleAndValueResult();
  // 구분자 앞의 모든문자를 title로 사용
  {
    var reg = RegExp('.+(?=[:\-=])');
    var firstMatch = reg.firstMatch(text);
    if (firstMatch == null) return null;

    re.title = text.substring(firstMatch.start, firstMatch.end);
    re.title = re.title.trim();
  }

  // 구분자 뒤의 모든 문자를 value로 사용
  {
    var reg = RegExp('[:\-=].+');
    var firstMatch = reg.firstMatch(text);
    if (firstMatch == null) return null;

    re.value = text.substring(firstMatch.start + 1, firstMatch.end);
    re.value = re.value.trim();
  }

  return re;
}
