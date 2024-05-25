import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './cart.dart';

class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime});
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get orders{
  return [..._orders];
  }

  Future<void> fetchAndSetOrders() async{
    Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/orders.json");
    final response = await http.get(uri);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(id: orderId, amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((item)=> CartItem(id: item['id'], title: item['title'], quantity: item['quantity'], price: item['price'])).toList(),
          dateTime: DateTime.parse(orderData['dataTime'])
      ),
      );
    });
  _orders = loadedOrders.reversed.toList();
  notifyListeners();
  }
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/orders.json");
    final timestamp = DateTime.now();
    final response = await http.post(uri,
    body: json.encode({
      'amount' : total,
      'dataTime' : timestamp.toIso8601String(),
      'products'  : cartProducts
      .map((cp) =>{
        'id' : cp.id,
        'title' : cp.title,
        'quantity' : cp.quantity,
        'price' : cp.price,
    }).toList(),
    }),
    );
    _orders.insert(0, OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now())
    );
    notifyListeners();
  }
}