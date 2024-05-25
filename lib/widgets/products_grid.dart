import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget{
  final bool showfavs;

  ProductsGrid(this.showfavs);

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    final products  = showfavs ? productsdata.FavoriteItem : productsdata.items;
    return GridView.builder(
      padding:  const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        // create: (c) => products[i],
        child: ProductItem(
          // id: products[i].id,
          // title: products[i].title,
          // imageUrl: products[i].imageURL,
      ), ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10, mainAxisSpacing: 10
      ) ,
    );
  }
}