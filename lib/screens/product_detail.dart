import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetail extends StatelessWidget{
  // final String title;
  //
  // ProductDetail(this.title);
static const routeName =  '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedproduct = Provider.of<Products>(context,
        listen: false)
        .findbyid(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedproduct.title
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image.asset(loadedproduct.imageURL,
              fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,
            ),
            Text('\$${loadedproduct.price}',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20),
            ),
            SizedBox(height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child:
              Text(loadedproduct.description,
              textAlign: TextAlign.center,
              softWrap: true,),
            )
          ],
        ),
      ),
    );
  }

}