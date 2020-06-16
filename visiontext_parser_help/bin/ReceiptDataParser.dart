import 'TextParserResult.dart';
import 'TitleAndDataFinder.dart';
import 'TextParser.dart' as text_parser;
import 'ProductItem.dart';

// 영수증 데이타 변환기
class ReceiptDataParser {
  // 파싱 결과
  DateTime _deliveryDate;
  DateTime _invoiceDate;
  String _invoiceTo;
  List<ProductItem> _items;
  double _total;
  TitleAndDataFinder _finder;

  // 생성자
  // 여기서 모두 찾는다.
  ReceiptDataParser(List<String> textLines) {
    _finder = TitleAndDataFinder(textLines);

    // delivery date
    findDeliveryDate();

    // invoice date
    findInvoiceDate();

    // invoice to
    findInvoiceTo();

    // 상품 찾기
    findProductItems();

    // total 찾기
    findTotal();
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
    var exp = RegExp('.+(?=invoice Date)', caseSensitive: false);
    return text.replaceFirst(exp, '');
  }

  @override
  String toString() {
    var str = '';

    str += 'Delivery Date : ';
    str += _deliveryDate.toString();

    str += '\nInvoice Date : ';
    str += _invoiceDate.toString();

    str += '\nInvoice To : ';
    str += _invoiceTo.toString();

    for (var item in _items) {
      str += '\n' + item.toString();
    }

    str += '\nTotal : ';
    str += _total.toString();
    return str;
  }

  // delivery date를 찾는다.
  void findDeliveryDate() {
    var text = _finder.findTextLineByIncludingText('delivery date');
    if (text != null) {
      // invoice date 앞은 제거
      text = removeTextBeforeTitle(text, 'delivery date');

      var re = text_parser.splitTitleAndValue(text);
      if (re != null) {
        _deliveryDate = text_parser.textToDateTime(re.value);
      }
    }
  }

  // invoice date를 찾는다.
  void findInvoiceDate() {
    var text = _finder.findTextLineByIncludingText('invoice date');
    if (text != null) {
      {
        // invoice date 앞은 제거
        text = removeTextBeforeTitle(text, 'invoice date');
        var re = text_parser.splitTitleAndValue(text);
        if (re != null) {
          _invoiceDate = text_parser.textToDateTime(re.value);
        }
      }
    }
  }

  // invoice to를 찾는다.
  void findInvoiceTo() {
    var text = _finder.findTextLineByIncludingText('invoice to');
    if (text != null) {
      // invoice date 앞은 제거
      text = removeTextBeforeTitle(text, 'invoice to');
      text = removeTextAfterSecondSeparator(text, ':');

      var re = text_parser.splitTitleAndValue(text);
      if (re != null) {
        _invoiceTo = re.value;
      }
    }
  }

  // 모든 상품을 찾는다.
  // TODO : 상품을 세분화 하는 코드를 작성해야함.
  void findProductItems() {
    _items = <ProductItem>[];

    // 가격이 있는 text line을 모두 찾아 온다.
    var priceTextLines = _finder.findAllPriceTextLinesByIncludingText('');
    if (priceTextLines == null || priceTextLines.isEmpty) return;

    // 가장 큰 값을 찾는다.
    for (var textLine in priceTextLines) {
      var re = text_parser.splitPriceTitalAndValue(textLine);

      // 삼풍이 아니라면 통과
      if (!isProductItem(re)) continue;

      if (re != null) {
        var item = ProductItem();
        item.name = re.title;
        item.price = text_parser.textToPrice(re.value);
        _items.add(item);
      }
    }
  }

  // total을 찾는다.
  // 1. total이 붙어 있는 금액 중에서 가장 큰 금액이 진짜 total이다.
  void findTotal() {
    var totalTextLines = _finder.findAllPriceTextLinesByIncludingText('total');
    if (totalTextLines == null || totalTextLines.isEmpty) return;

    // 가장 큰 값을 찾는다.
    for (var textLine in totalTextLines) {
      var re = text_parser.splitPriceTitalAndValue(textLine);
      if (re != null) {
        var price = text_parser.textToPrice(re.value);
        if (_total == null || _total < price) _total = price;
      }
    }
  }

  // 삼풍이 아니라면 통과
  // title의 시작이 특정 문자로 시작한다면 상품이 아님
  bool isProductItem(TitleAndValueResult re) {
    // title의 시작이 total과 관련된 문자라면 상품이 아님
    var reg = RegExp(r'(total|subtotal|gst).+', caseSensitive: false);
    var firstMatch = reg.firstMatch(re.title);
    if (firstMatch != null && firstMatch.start == 0) return false;

    return true;
  }
}
