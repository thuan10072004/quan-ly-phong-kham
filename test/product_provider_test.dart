import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/models/product.dart';

void main() {
  group('Product Model Test', () {
    // Test 1: Kiểm tra việc tạo đối tượng cơ bản
    test('Product should be created correctly', () {
      final product = Product(
          id: '1', name: 'Panadol', price: 5000, category: 'Painkiller');

      expect(product.name, 'Panadol');
      expect(product.price, 5000.0); // Giá phải là số thực (double)
      expect(product.category, 'Painkiller');
    });

    // Test 2: Kiểm tra hàm toMap (Dùng khi gửi dữ liệu lên Server PHP)
    test('toMap should convert data to String for API', () {
      final product =
          Product(id: '1', name: 'Vitamin C', price: 10000, category: 'Health');
      final map = product.toMap();

      expect(map['name'], 'Vitamin C');
      // API PHP yêu cầu gửi giá dạng String, kiểm tra xem đã chuyển chưa
      expect(map['price'], '10000.0');
    });

    // Test 3: [QUAN TRỌNG] Kiểm tra hàm fromMap (Nhận dữ liệu từ MySQL)
    // MySQL thường trả về số dưới dạng String, Model phải tự ép kiểu về Double
    test('fromMap should parse String price from API to Double', () {
      final apiData = {
        'id': '99',
        'name': 'Thuốc Test',
        'price': '55000', // Giả sử API trả về chuỗi "55000"
        'category': 'Test'
      };

      final product = Product.fromMap(apiData);

      expect(product.name, 'Thuốc Test');
      expect(product.price, 55000.0); // Model phải tự hiểu đây là số 55000.0
    });
  });
}
