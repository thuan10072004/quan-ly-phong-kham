import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
// Đổi 'flutter_project' thành tên project thực tế trong pubspec.yaml của bạn nếu khác
import 'package:flutter_project/main.dart';
import 'package:flutter_project/providers/product_provider.dart';

// --- 1. TẠO PROVIDER GIẢ (MOCK) ---
// Class này kế thừa ProductProvider nhưng VÔ HIỆU HÓA phần gọi API
class MockProductProvider extends ProductProvider {
  @override
  Future<void> fetchProducts() async {
    // Thay vì gọi HTTP, ta không làm gì cả hoặc nạp dữ liệu giả ngay lập tức
    // Điều này giúp Test chạy cực nhanh và không bị lỗi mạng
    return Future.value();
  }
}

void main() {
  testWidgets('Kiểm tra ứng dụng mở lên thành công',
      (WidgetTester tester) async {
    // --- 2. NẠP MÔI TRƯỜNG GIẢ LẬP ---
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          // Nạp MockProductProvider thay vì ProductProvider thật
          ChangeNotifierProvider<ProductProvider>(
            create: (_) => MockProductProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );

    // --- 3. KIỂM TRA GIAO DIỆN ---
    // Chờ app dựng hình xong
    await tester.pump();

    // Kiểm tra xem trên màn hình có hiện chữ 'Kho Thuốc' (Tiêu đề App) không
    // Lưu ý: Sửa chữ này khớp với title trong AppBar của HomeScreen
    expect(find.text('Kho Thuốc'), findsOneWidget);

    // Kiểm tra xem có nút thêm (+) không
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
