import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/card_screen.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOption{
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget{

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAnsSetProduct();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit){
      setState(() {
        _isLoading =true;
      });
      Provider.of<Products>(context).fetchAnsSetProduct()
      .then((_){
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectedValue){
              setState(() {
                if(selectedValue == FilterOption.Favorites){
                  _showOnlyFavorite = true;
                }
                else
                {
                  _showOnlyFavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(child: Text('Only Favorite'),value: FilterOption.Favorites,),
              PopupMenuItem(child: Text('Show All'), value: FilterOption.All)
          ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badges(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
              child: IconButton(
                  icon: Icon(
                      Icons.shopping_cart
                  ),
                onPressed: (){
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ?
      Center(child: CircularProgressIndicator(),)
          :ProductsGrid(_showOnlyFavorite),
    );
  }
}

