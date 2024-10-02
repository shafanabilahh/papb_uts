import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String product;
  final String image;
  final bool isAdded;
  final VoidCallback addToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.image,
    required this.isAdded,
    required this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 100,
          ),
          SizedBox(height: 10),
          Text(product),
          SizedBox(height: 10),
          isAdded
              ? Text(
                  'Added to Cart',
                  style: TextStyle(color: Colors.green),
                )
              : ElevatedButton(
                  onPressed: addToCart,
                  child: Text('Add to Cart'),
                ),
        ],
      ),
    );
  }
}
