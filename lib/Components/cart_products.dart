import 'package:flutter/material.dart';

import 'package:touristaan_v1/Components/cart_products.dart';
import 'package:touristaan_v1/Components/products.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Hunza",
      "picture": "images/Destinations/hunza/hunza3.jpg",
      "price": 15000,
      "Location" : "Gilgit-Baltistan",


    },
    {
      "name": "Saif-ul-malok",
      "picture": "images/Destinations/Saiful_malok/saifc3.jpg",
      "price": 25000,
      "Location" : "Mansehra district",


    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: Products_on_the_cart.length,
      itemBuilder: (context, index){
        return Sinlge_cart_product(
          cart_product_name: Products_on_the_cart[index]["name"],
          cart_prod_location: Products_on_the_cart[index]["locaion"],
          cart_product_picture: Products_on_the_cart[index]["picture"],
          cart_prod_price: Products_on_the_cart[index]["price"],

        );
      },
    );
  }
}
class Sinlge_cart_product extends StatelessWidget {
  final  cart_product_name;
  final  cart_product_picture;
  final  cart_prod_price;
  final  cart_prod_location;


  Sinlge_cart_product(
      {this.cart_product_name,
        this.cart_product_picture,
        this.cart_prod_location,
        this.cart_prod_price,


      });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
//        ******* LEading SECTION********
        leading: new Image.asset(cart_product_picture, width: 80, height: 80,),

//        ************Titile Section*************
        title: new Text(cart_product_name),

//        ******Subtitile Secion*******
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("Price per Person"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text("$cart_prod_price"),
                ),



              ],
            ),

//            ************* THIS SECTION IS THE PRODUYCT PRICE*************
            Container(
              alignment: Alignment.topLeft,
              child: new Text("\$${cart_prod_price}",
                  style: TextStyle(color: Colors.red,)),)

          ],
        ),
        trailing: new Column(
          children: <Widget>[

            Expanded(child: new IconButton(
                icon: Icon(Icons.arrow_drop_up), onPressed: () {})),
            new Text("1 person"),
            Expanded(child: new IconButton(
                icon: Icon(Icons.arrow_drop_down), onPressed: () {})),
          ],
        ),
      ),
    );
  }
}
