import 'package:first_app/components/dot_carousel.dart';
import 'package:first_app/components/products.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final icons = product.gallery.isNotEmpty ? product.gallery : [product.icon];

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.grey.shade900),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DotCarousel(
            items: [
              for (final icon in icons)
                Icon(icon, size: 140, color: Colors.black87),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            product.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(product.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          Text(
            '\$${product.price.toStringAsFixed(product.price % 1 == 0 ? 0 : 2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ],
      ),
    );
  }
}
