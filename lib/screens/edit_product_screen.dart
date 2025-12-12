import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  // Nếu product là null -> Chế độ Thêm mới
  // Nếu product có dữ liệu -> Chế độ Chỉnh sửa
  final Product? product;

  const EditProductScreen({super.key, this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>(); // Key để quản lý Form và Validation

  // Các controller để lấy dữ liệu từ ô nhập
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị ban đầu (nếu là sửa thì điền sẵn dữ liệu cũ)
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(
        text: widget.product != null
            ? widget.product!.price.toStringAsFixed(0)
            : '');
    _categoryController =
        TextEditingController(text: widget.product?.category ?? '');
  }

  @override
  void dispose() {
    // Giải phóng bộ nhớ khi thoát màn hình (Clean Code)
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi nhấn nút Lưu
  Future<void> _saveForm() async {
    // 1. Chạy validation
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return; // Dừng lại nếu dữ liệu không hợp lệ
    }

    setState(() {
      _isLoading = true; // Hiện loading
    });

    final name = _nameController.text;
    final price = double.parse(_priceController.text);
    final category =
        _categoryController.text.isEmpty ? 'Chung' : _categoryController.text;
    final provider = Provider.of<ProductProvider>(context, listen: false);

    try {
      if (widget.product == null) {
        // --- TRƯỜNG HỢP THÊM MỚI ---
        // ID sẽ được tạo tự động trong Provider, ở đây truyền tạm rỗng
        final newProduct =
            Product(id: '', name: name, price: price, category: category);
        await provider.addProduct(newProduct);
      } else {
        // --- TRƯỜNG HỢP CẬP NHẬT ---
        // Giữ nguyên ID cũ
        final updatedProduct = Product(
          id: widget.product!.id,
          name: name,
          price: price,
          category: category,
        );
        await provider.updateProduct(updatedProduct);
      }

      // Lưu thành công -> Quay về màn hình trước
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Lưu thành công!'), backgroundColor: Colors.green),
        );
      }
    } catch (error) {
      // Xử lý lỗi nếu có
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Có lỗi xảy ra: $error'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Xác định tiêu đề dựa trên context
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Cập nhật thuốc' : 'Thêm thuốc mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- NHẬP TÊN THUỐC ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên thuốc/Sản phẩm',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.medication),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên thuốc.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- NHẬP GIÁ TIỀN ---
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Giá bán (VNĐ)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập giá.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Giá phải là số hợp lệ.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Giá phải lớn hơn 0.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- NHẬP DANH MỤC ---
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Danh mục (Ví dụ: Kháng sinh, Vitamin...)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _saveForm(), // Nhấn Enter để lưu
              ),
              const SizedBox(height: 24),

              // --- NÚT LƯU ---
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text(
                          isEditing ? 'CẬP NHẬT' : 'THÊM MỚI',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
