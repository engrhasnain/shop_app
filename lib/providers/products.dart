import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
  //   Product(
  //           id: 'p1',
  //           title: 'Red Shirt',
  //           description: 'A red Shirt - it is a pretty one',
  //           price: 29.99,
  //           imageURL: 'assets/images/R.jpg'),
  // Product(
  // id: 'p2',
  // title: 'Yellow Pant',
  // description: 'A Yellow pant - it is a pretty one',
  // price: 59.99,
  // imageURL: 'assets/images/d.jpg'),
  // Product(
  // id: 'p3',
  // title: 'black cap',
  // description: 'A cap - it is a pretty one',
  // price: 19.19,
  // imageURL: 'assets/images/j.jpg'),
  // Product(
  // id: 'p4',
  // title: 'belt',
  // description: 'A belt - it is a pretty one',
  // price: 09.99,
  // imageURL: 'assets/images/re.jpg')
  ];



  List<Product> get items{
    return [..._items];
  }

  List<Product> get FavoriteItem{
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findbyid(String id)
  {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAnsSetProduct() async {
    Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/products.json");
    try{
      final response = await http.get(uri);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if(extractedData == null){
        return;
      }
      extractedData.forEach((prodId, probData) {
        loadedProducts.add(Product(
          id:prodId,
          title: probData['title'],
          description: probData['description'],
          price: probData['price'],
          isFavorite : probData['isFavorite'],
          imageURL: probData['imageURL']
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    }catch (error){
      throw (error);
    }
  }
  Future<void> addProduct(Product product) async{
    Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/products.json");
   try {
     final response = await http.post(uri, body: json.encode({ 
       'title': product.title,
       'description': product.description,
       'imageURL': product.imageURL,
       'price': product.price,
       'isFavorite': product.isFavorite
     }),);
     final newProduct = Product(
         id: DateTime.now().toString(),
         title: product.title,
         description: product.description,
         price: product.price,
         imageURL:
         product.imageURL);
     _items.add(newProduct);
     // _items.insert(0,newProduct);
     notifyListeners();
   } catch (error) {
     print(error);
     throw error;
   }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/products/$id.json");
      await http.patch(uri, body: json.encode({
        'title' : newProduct.title,
        'description': newProduct.description,
        'imageURL' : newProduct.imageURL,
        'price' : newProduct.price
      }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    Uri uri = Uri.parse("https://flutter-shopapp-cb2f4-default-rtdb.firebaseio.com/products/$id.json");
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id );
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(uri);
      if(response.statusCode >= 400){
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not delete product');
      }
      existingProduct = '' as Product;

    // _items.removeWhere((prod) => prod.id == id);
    // notifyListeners();
  }
}