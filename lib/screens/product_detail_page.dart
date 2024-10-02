import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/cart_bloc.dart';
import '../widgets/cart_event.dart';

class ProductDetailPage extends StatelessWidget {
  final String product;
  final String image;
  final String brand;
  final String weight;
  final String description;

  ProductDetailPage({
    required this.product,
    required this.image,
    required this.brand,
    required this.weight,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product),
      ),
      body: SingleChildScrollView( // Menggunakan SingleChildScrollView untuk scroll
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(image, height: 200), // Gambar Produk
              ),
              SizedBox(height: 20),
              Text(
                product,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Brand: $brand',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 8),
              Text(
                'Weight: $weight',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Menggunakan Bloc untuk menambahkan produk ke keranjang
                    context.read<CartBloc>().add(AddToCartEvent(
                      productName: product,
                      productImage: image,
                    ));
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  child: Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
