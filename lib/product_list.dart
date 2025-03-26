import 'package:flutter/material.dart';
import 'product.dart';
import 'product_service.dart';

class ProductList extends StatelessWidget {
  final ProductService _productService = ProductService();

  ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productService.getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              );
            },
          );
        }
      },
    );
  }
}
