// 상품 1개에 대한 클래스
class ProductItem {
  String name; // 상품명
  int qty; // 삼품갯수
  double unit_price; // 개당 단가
  double gst; // 세금(선택)
  double price; // 가격(필수)

  @override
  String toString() {
    return 'Item name - $name, Qty - $qty, Unit Price - $unit_price, GST - $gst, Price - $price';
  }
}
