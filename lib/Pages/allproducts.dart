import 'package:flutter/material.dart';
import 'package:touristaan_v1/Components/HorizontalListView.dart';
import 'package:touristaan_v1/Components/products.dart';

class allProducts extends StatefulWidget {
  @override
  _allProductsState createState() => _allProductsState();
}

class _allProductsState extends State<allProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Available Packages'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),

        ],
      ),

      body: ListView(

        children: <Widget> [

//          new Padding(padding: const EdgeInsets.all(20.0),
//            child: new Text("All Availabkle Packages",
//              textAlign: TextAlign.center,
//              style: TextStyle(fontWeight: FontWeight.bold,
//                  decoration: TextDecoration.underline),),
//          ),

          Container(
//            height: 400,
            height: MediaQuery. of(context). size. height,
            child: Products(),
          ),

        ],

      ),

      bottomNavigationBar: Container(child: HorizontalList()),





      );

  }
}
