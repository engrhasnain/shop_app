import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:shop_app/screens/product_detail.dart';


import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child:
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(
                 ProductDetail.routeName,
                  arguments: product.id,
                );
              },
                child: Image.asset(product.imageURL)),
        // Image.network(imageUrl, fit: BoxFit.cover,),
        footer:GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              color: Colors.deepOrange,
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: (){
                product.togglefavorite();
              },),
          ),
          title: Text(product.title, textAlign:
          TextAlign.center,),  
          trailing: IconButton(
              onPressed: (){
                cart.addItem(product.id,
                    product.title,
                    product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                Text("Added Item to Chart"),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: (){
                    cart.removeSingleItem(product.id);
                  },
                ),
                ),
                );

              },
              color: Colors.deepOrange,
              icon: Icon(Icons.shopping_cart)),
        ),
      ),
    );
  }

}