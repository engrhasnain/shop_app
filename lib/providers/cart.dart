

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier{
Map<String, CartItem> _items = {};

Map<String, CartItem> get items{
 return  {..._items};
}

double get totalAmount{
  var total = 0.0;
  _items.forEach((key, cartItem) {
    total += cartItem.price*cartItem.quantity;
  });
  return total;
}

int get itemCount{
  return _items.length;
}

void addItem(String productId, String title, double price){
  if(_items.containsKey(productId)){
    _items.update(productId, (existing) => CartItem(id: existing.id,
        title: existing.title,
        quantity: existing.quantity + 1,
        price: existing.price
    ),
    );

  }
  else{
    _items.putIfAbsent(productId, () => CartItem(id: productId,
        title: title,
        quantity: 1,
        price: price));
  }
notifyListeners();
}

void removeItem(String productId){
  _items.remove(productId);
  notifyListeners();
}

void clear() {
  _items = {};
  notifyListeners();
}

void removeSingleItem(String productId){
  if(!_items.containsKey(productId)){
    return;
  }
  if(_items[productId]!.quantity > 1){
    _items.update(productId, (existing) =>
    CartItem(id: existing.id,
        title: existing.title,
        quantity: existing.quantity - 1,
        price: existing.price));
  }else{
  _items.remove(productId);
  }
notifyListeners();
}
}