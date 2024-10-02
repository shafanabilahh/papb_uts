import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/cart_bloc.dart';
import '../widgets/cart_state.dart';
import '../widgets/cart_event.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.cartItems.isEmpty) {
            return Center(child: Text('No items in the cart'));
          }
          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final item = state.cartItems[index];
              return ListTile(
                leading: Image.asset(item.productImage, width: 50),
                title: Text(item.productName),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        context.read<CartBloc>().add(DecreaseQuantityEvent(productName: item.productName));
                      },
                    ),
                    Text(item.quantity.toString()),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        context.read<CartBloc>().add(IncreaseQuantityEvent(productName: item.productName));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<CartBloc>().add(RemoveFromCartEvent(productName: item.productName));
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
