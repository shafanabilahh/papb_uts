// widgets/cart_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartItems: [])) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncreaseQuantityEvent>(_onIncreaseQuantity);
    on<DecreaseQuantityEvent>(_onDecreaseQuantity);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    // Salin cartItems dari state saat ini dengan tipe yang benar
    final cartItems = List<CartItem>.from(state.cartItems);
    final index = cartItems.indexWhere((item) => item.productName == event.productName);

    if (index != -1) {
      // Jika produk sudah ada di keranjang, tingkatkan kuantitasnya
      cartItems[index].quantity++;
    } else {
      // Jika produk belum ada, tambahkan ke keranjang
      cartItems.add(CartItem(
        productName: event.productName,
        productImage: event.productImage,
        quantity: 1,
      ));
    }

    emit(CartState(cartItems: cartItems)); // Emit state baru
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    // Salin cartItems dari state saat ini dengan tipe yang benar
    final cartItems = List<CartItem>.from(state.cartItems);
    cartItems.removeWhere((item) => item.productName == event.productName);
    emit(CartState(cartItems: cartItems));
  }

  void _onIncreaseQuantity(IncreaseQuantityEvent event, Emitter<CartState> emit) {
    // Salin cartItems dari state saat ini dengan tipe yang benar
    final cartItems = List<CartItem>.from(state.cartItems);
    final index = cartItems.indexWhere((item) => item.productName == event.productName);
    
    if (index != -1) {
      cartItems[index].quantity++;
    }
    
    emit(CartState(cartItems: cartItems));
  }

  void _onDecreaseQuantity(DecreaseQuantityEvent event, Emitter<CartState> emit) {
    // Salin cartItems dari state saat ini dengan tipe yang benar
    final cartItems = List<CartItem>.from(state.cartItems);
    final index = cartItems.indexWhere((item) => item.productName == event.productName);
    
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
    
    emit(CartState(cartItems: cartItems));
  }
}
