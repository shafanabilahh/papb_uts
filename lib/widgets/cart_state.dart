class CartItem {
  final String productName;
  final String productImage;
  int quantity;

  CartItem({required this.productName, required this.productImage, required this.quantity});
}

class CartState {
  final List<CartItem> cartItems;

  CartState({this.cartItems = const []});
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  CartLoaded(this.cartItems);
}
