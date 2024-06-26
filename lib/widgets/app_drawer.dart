import 'package:flutter/material.dart';
import 'package:shop_app/screens/user_product_screen.dart';

import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';
class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friends'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
          title: Text('Shop'),
          onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
          },),




          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Orders"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Manage Products"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },
          )
        ],
      ),
    );
  }

}