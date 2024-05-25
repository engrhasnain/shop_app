import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';

import '../providers/cart.dart';
import '../providers/order.dart';
import '../widgets/card_item.dart' as ci;

class CartScreen extends StatelessWidget{
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total', style: TextStyle(fontSize: 20),),
                SizedBox(width: 10,),
                Spacer(),
                Chip(label: Text('\$${cart.totalAmount}',),
                backgroundColor: Theme.of(context).primaryColor,),
                OrderButton(cart: cart)
              ],
            ),
          ),
          ),
          SizedBox(height: 10,),
          Expanded(child: ListView.builder(
              itemCount: cart.items.length,
            itemBuilder: (ctx,i) => ci.CardItem(
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].title),
          ),
          ),
        ],
      ),
    );
  }

}

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({
    required this.cart,
  });

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton>{
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.totalAmount <=0 ? null : () async{
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount,
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
    );
  }
}