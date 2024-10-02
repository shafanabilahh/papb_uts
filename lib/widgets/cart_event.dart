abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String productName;
  final String productImage;

  AddToCartEvent({required this.productName, required this.productImage});
}

class RemoveFromCartEvent extends CartEvent {
  final String productName;

  RemoveFromCartEvent({required this.productName});
}

class IncreaseQuantityEvent extends CartEvent {
  final String productName;

  IncreaseQuantityEvent({required this.productName});
}

class DecreaseQuantityEvent extends CartEvent {
  final String productName;

  DecreaseQuantityEvent({required this.productName});
}
