import 'TitleAndDataFinder.dart';
import 'TextParser.dart' as textParser;
import 'TextParserResult.dart';

class ReceiptDataParser {
  // 파싱 결과
  DateTime _deliveryDate;
  DateTime _invoiceDate;
  String _invoiceTo;

  ReceiptDataParser(List<String> textLines) {
    TitleAndDataFinder finder = TitleAndDataFinder(textLines);

    // delivery date
    {
      var text = finder.FindTextLineByIncludingText('delivery date');
      if (text != null) {
        // invoice date 앞은 제거
        text = removeTextBeforeTitle(text, 'delivery date');

        var re = textParser.SplitTitleAndValue(text);
        if (re != null) {
          _deliveryDate = textParser.TextToDateTime(re.value);
        }
      }
    }

    // invoice date
    {
      var text = finder.FindTextLineByIncludingText('invoice date');
      if (text != null) {
        {
          // invoice date 앞은 제거
          text = removeTextBeforeTitle(text, 'invoice date');
          var re = textParser.SplitTitleAndValue(text);
          if (re != null) {
            _invoiceDate = textParser.TextToDateTime(re.value);
          }
        }
      }
    }
    // invoice to
    {
      var text = finder.FindTextLineByIncludingText('invoice to');
      if (text != null) {
        // invoice date 앞은 제거
        text = removeTextBeforeTitle(text, 'invoice to');
        text = removeTextAfterSecondSeparator(text, ':');

        var re = textParser.SplitTitleAndValue(text);
        if (re != null) {
          _invoiceTo = re.value;
        }
      }
    }
  }

  // 두번째이후 구분자를 제거한다.
  String removeTextAfterSecondSeparator(String text, String separator) {
    var reg = RegExp(separator);
    var allMatches = reg.allMatches(text);

    if (allMatches.length < 2) return text;
    var match = allMatches.elementAt(1);
    return text.substring(0, match.start);
  }

  // title 앞부분을 제거한다.
  String removeTextBeforeTitle(String text, String title) {
    RegExp exp = RegExp('.+(?=invoice Date)', caseSensitive: false);
    return text.replaceFirst(exp, '');
  }

  @override
  String toString() {
    String str = '';

    str += 'Delivery Date : ';
    str += _deliveryDate.toString();

    str += '\nInvoice Date : ';
    str += _invoiceDate.toString();

    str += '\nInvoice To : ';
    str += _invoiceTo.toString();
    return str;
  }
}
