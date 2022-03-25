import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    
    return _items.length;

    //return the total amount of products in the cart just each product category
    // int get totalItemCount {
    // int totalItemsInCart = 0;
    // for (var cartItem in _items.entries) {
    //   totalItemsInCart = totalItemsInCart + cartItem.value.quantity;
    // }
    // return totalItemsInCart;
    // }
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              title: existingCartItem.title));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            price: price,
            quantity: 1,
            title: title),
      );
    }
    notifyListeners();
  }
}
