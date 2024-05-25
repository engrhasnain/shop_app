import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';


import './screens/product_overview.dart';
import './screens/product_detail.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/card_screen.dart';
// import './providers/order.dart';

import './screens/order_screen.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MultiProvider(providers: [
     ChangeNotifierProvider(
       create: (ctx) => Products()
       ),
     ChangeNotifierProvider(
         create: (ctx) => Cart()
     ),
     ChangeNotifierProvider(
         create: (ctx) => Orders()
     ),
   ],
     child: MaterialApp(
       title: 'MyShop',
       theme: ThemeData(
         primarySwatch: Colors.purple,
       ),
       home: ProductsOverviewScreen(),

       routes: {
         ProductDetail.routeName: (ctx) => ProductDetail(),
         CartScreen.routeName: (ctx) => CartScreen(),
         OrdersScreen.routeName: (ctx) => OrdersScreen(),
         UserProductScreen.routeName: (ctx) => UserProductScreen(),
        EditProductScreen.routeName: (ctx) => EditProductScreen(),
       }
      ),
   );
  }
}
