import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/cart_bloc.dart';
import '../widgets/cart_event.dart';
import '../widgets/cart_state.dart'; // Pastikan ada file cart_state.dart untuk Bloc state
import '../widgets/product_cart.dart'; // Sesuaikan dengan file ProductCard
import 'cart_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  // Daftar produk hanya dengan nama dan gambar
  final List<Map<String, String>> products = [
    {
      'name': 'Moisturizer',
      'image': 'assets/images/moist.png',
      'brand': 'Glad2Glow',
      'weight': '30g',
      'description': 'Moisturizer containing Pomegranate and 5% Niacinamide which can brighten and help even out skin tone. It has a light texture that is easily absorbed, can be used morning and evening.'
    },
    {
      'name': 'Serum',
      'image': 'assets/images/serum.png',
      'brand': 'Nutrishe',
      'weight': '30ml',
      'description': 'Serum containing alpha arbutin which is useful for brightening skin color and disguising black spots. This serum has a light texture and is easily absorbed into the skin. Equipped with centella asiatica which can help soothe the skin.'
    },
    {
      'name': 'Sunscreen',
      'image': 'assets/images/sunsc.png',
      'brand': 'Facetology',
      'weight': '40ml',
      'description': 'Formulated with a HYBRID formulation by combining both types of UV Filters, both physical and chemical, to provide maximum protection against exposure to UV rays from the sun.'
    },
    {
      'name': 'Toner',
      'image': 'assets/images/toner.png',
      'brand': 'Avoskin',
      'weight': '100ml',
      'description': 'An effective toner to maximize the skin exfoliation process while maintaining skin moisture, disguise black spots, disguise the appearance of pores, help smooth skin texture, help brighten and even out skin tone.'
    },
    {
      'name': 'Cleanser',
      'image': 'assets/images/wash.png',
      'brand': 'COSRX',
      'weight': '150ml',
      'description': 'A facial cleanser from South Korea that uses natural ingredients with a gentle formula that is good for use in the morning.'
    },
    {
      'name': 'Clay Mask',
      'image': 'assets/images/mask.png',
      'brand': 'Skintific',
      'weight': '40g',
      'description': 'Support brightening booster product that infused with Niacinamide, Pink Sea Salt, and Tranexamic Acid to brightens and evens skin tone. Synergy to get your Glowing and skin radiance complexion.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              int totalItems = 0;

              if (state is CartLoaded) {
                totalItems = state.cartItems.fold(
                    0, (previousValue, item) => previousValue + item.quantity);
              }

              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage()),
                      );
                    },
                  ),
                  if (totalItems > 0) // Menampilkan jumlah item di keranjang
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$totalItems',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(
                    product: products[index]['name']!,
                    image: products[index]['image']!,
                    brand: products[index]['brand']!,
                    weight: products[index]['weight']!,
                    description: products[index]['description']!,
                  ),
                ),
              );
            },
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                bool isAdded = state.cartItems.any((item) => item.productName == products[index]['name']);
                
                return ProductCard(
                  product: products[index]['name']!,
                  image: products[index]['image']!,
                  isAdded: isAdded, // Mengatur status apakah produk sudah ditambahkan ke keranjang
                  addToCart: () {
                    context.read<CartBloc>().add(AddToCartEvent(
                      productName: products[index]['name']!,
                      productImage: products[index]['image']!,
                    ));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
