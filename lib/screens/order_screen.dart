// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
 import '../providers/order.dart' show Orders;
// import '../widgets/order_item.dart';
// import '../widgets/app_drawer.dart';
//
// class OrdersScreen extends StatefulWidget{
//   static const routeName = '/orders';
//
//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }
//
// class _OrdersScreenState extends State<OrdersScreen> {
//   var _isLoading = false;
//   @override
//   void initState() {
//     Future.delayed(Duration.zero).then((_) async{
//       setState(() {
//         _isLoading= true;
//       });
//       await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
//     setState(() {
//       _isLoading = false;
//     });
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     final orderData = Provider.of<Orders>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Your Orders"),
//       ),
//       drawer: AppDrawer(),
//       body: _isLoading ? Center(
//         child: CircularProgressIndicator(),
//       ) :
//       ListView.builder(
//           itemCount: orderData.orders.length,
//         itemBuilder: (ctx, i) =>
//             OrderItem(orderData.orders[i]),
//       )
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // ...
              // Do error handling stuff
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData!.orders[i]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
