class Product {
  final String id;
  final String name;
  final double price;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  // Chuyển đối tượng thành Map để gửi lên Server (nếu cần)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price.toString(),
      'category': category,
    };
  }

  // Nhận dữ liệu từ Server (JSON) chuyển thành đối tượng Dart
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      // MySQL id là số, ta chuyển thành String cho thống nhất
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      // Chuyển giá thành số thực, phòng trường hợp null hoặc chuỗi
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0.0,
      category: map['category'] ?? '',
    );
  }
}
