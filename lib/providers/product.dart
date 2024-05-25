import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageURL;
  bool isFavorite;

  Product(
      {required this.id,
        required this.title,
        required this.description,
        required this.price,
        required this.imageURL,
        this.isFavorite = false,
        String? imageUrl,
      });

  Future<void> togglefavorite() async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite ;
    notifyListeners();
    Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/products/$id.json");
    try{
      await http.patch(uri, body: json.encode({
        'isFavorite' : isFavorite,
      }));
    }catch(error){
      isFavorite = oldStatus;
    }

  }
}