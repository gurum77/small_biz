import 'TitleAndDataFinder.dart';

class ReceiptDataParser
{
  // 파싱 결과
  DateTime _deliveryDate;
  DateTime _invoiceDate;

  ReceiptDataParser(List<String> textLines)
  {
    TitleAndDataFinder finder = TitleAndDataFinder(textLines);

    // 제목과 데이타가 있는 종류
    
    if(finder.FindByIncludingText('delivery date'))
    {
      
    }

  }



  @override
  String toString() {
    String str = '';

    str += 'Delivery Date : ';
    str += _deliveryDate.toString();

    str += '\nInvoice Date : ';
    str += _invoiceDate.toString();
    return str;
  }

}

