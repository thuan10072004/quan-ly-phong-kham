import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart'; // [MỚI] Thư viện để kiểm tra xem có phải Web không
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  // --- CẤU HÌNH ĐỊA CHỈ SERVER TỰ ĐỘNG ---
  // Hàm này sẽ tự kiểm tra nền tảng đang chạy là gì để chọn IP đúng
  static String get _baseUrl {
    if (kIsWeb) {
      // Nếu là Web -> Dùng localhost
      return 'http://localhost/api';
    } else {
      // Nếu là Android Emulator -> Dùng 10.0.2.2
      // Lưu ý: Nếu chạy máy thật (điện thoại Samsung/Xiaomi...) thì phải đổi dòng dưới thành IP máy tính (VD: 192.168.1.5)
      return 'http://10.0.2.2/api';
    }
  }

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;

  // --- 1. LẤY DANH SÁCH (READ) ---
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Gọi biến _baseUrl (nó sẽ tự chọn link đúng)
      print("Đang kết nối tới: $_baseUrl/get_products.php");

      final response = await http.get(Uri.parse('$_baseUrl/get_products.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _products = data.map((item) => Product.fromMap(item)).toList();
        _filteredProducts = List.from(_products);
      } else {
        print('Lỗi server: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // --- 2. THÊM MỚI (CREATE) ---
  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/add_product.php'),
        body: {
          'name': product.name,
          'price': product.price.toString(),
          'category': product.category,
        },
      );

      if (response.statusCode == 200) {
        await fetchProducts();
      }
    } catch (e) {
      print('Lỗi thêm: $e');
      rethrow;
    }
  }

  // --- 3. CẬP NHẬT (UPDATE) ---
  Future<void> updateProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update_product.php'),
        body: {
          'id': product.id,
          'name': product.name,
          'price': product.price.toString(),
          'category': product.category,
        },
      );

      if (response.statusCode == 200) {
        await fetchProducts();
      }
    } catch (e) {
      print('Lỗi sửa: $e');
      rethrow;
    }
  }

  // --- 4. XÓA (DELETE) ---
  Future<void> deleteProduct(String id) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/delete_product.php'),
        body: {'id': id},
      );

      if (response.statusCode == 200) {
        _products.removeWhere((p) => p.id == id);
        filterProducts('');
        notifyListeners();
      }
    } catch (e) {
      print('Lỗi xóa: $e');
    }
  }

  // --- TÍNH NĂNG PHỤ: SEARCH & SORT ---
  void filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = List.from(_products);
    } else {
      _filteredProducts = _products
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void sortProductsByPrice(bool ascending) {
    _filteredProducts.sort((a, b) =>
        ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    notifyListeners();
  }
}
