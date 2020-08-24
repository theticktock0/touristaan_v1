import 'package:flutter/material.dart';
import 'package:touristaan_v1/Components/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      ********APP BAR*******

      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.black54,
        centerTitle: true,
        title: Text('Cart'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),

        ],
      ),

      body: new Cart_products(),



//    **********Bottom Navigator*********

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text("Total:"),
                subtitle: new Text("\$230"),
              ),
            ),
            Expanded(
              child: new MaterialButton(onPressed: (){},
                child: new Text("Check Out",style: TextStyle(color: Colors.white),),
                color: Colors.red,
              ),

            )
          ],
        ),
      ),



    );
  }
}
