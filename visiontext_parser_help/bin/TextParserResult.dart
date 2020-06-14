// title and value 의 결과를 담는 클래스
class TitleAndValueResult {
  String title;
  String value;

  @override
  String toString() {
    var sb = StringBuffer();
    sb.writeln('title = $title');
    sb.writeln('value = $value');

    return sb.toString();
  }
}