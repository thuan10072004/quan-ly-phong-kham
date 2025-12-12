import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'edit_product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load dữ liệu khi vào app
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kho Thuốc'),
        actions: [
          // Sắp xếp (Feature điểm 10)
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              if (value == 'low_high')
                productProvider.sortProductsByPrice(true);
              if (value == 'high_low')
                productProvider.sortProductsByPrice(false);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 'low_high', child: Text('Giá: Thấp -> Cao')),
              const PopupMenuItem(
                  value: 'high_low', child: Text('Giá: Cao -> Thấp')),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm (Feature điểm 10)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm kiếm thuốc...',
                prefixIcon: const Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
              ),
              onChanged: (value) => productProvider.filterProducts(value),
            ),
          ),
          Expanded(
            child: productProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : productProvider.products.isEmpty
                    ? const Center(child: Text("Không có dữ liệu"))
                    : ListView.builder(
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) {
                          final product = productProvider.products[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: ListTile(
                              leading:
                                  CircleAvatar(child: Text(product.name[0])),
                              title: Text(product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${product.price} VNĐ - ${product.category}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditProductScreen(
                                              product: product)),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => productProvider
                                        .deleteProduct(product.id),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditProductScreen()),
        ),
      ),
    );
  }
}
