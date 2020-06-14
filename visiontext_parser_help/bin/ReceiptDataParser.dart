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
        var re = textParser.SplitTitleAndValue(text);
        if (re != null) {
          _invoiceDate = textParser.TextToDateTime(re.value);
        }
      }
    }
    // invoice to
    {
      var text = finder.FindTextLineByIncludingText('invoice to');
      if (text != null) {
        var re = textParser.SplitTitleAndValue(text);
        if (re != null) {
          _invoiceTo = re.value;
        }
      }
    }
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
