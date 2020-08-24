import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//**************** CUSTOM IMPORTS************

import 'package:touristaan_v1/Components/HorizontalListView.dart';
import 'package:touristaan_v1/Components/products.dart';
import 'package:touristaan_v1/Pages/login.dart';
import 'package:touristaan_v1/pages/cart.dart';
import 'allproducts.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/Carousel/dashboardc1.jpg'),
          AssetImage('images/Carousel/dashboardc4.jpg'),
          AssetImage('images/Carousel/dashboardc3.jpg'),
          AssetImage('images/Carousel/dashboardc5.jpg'),
          AssetImage('images/Carousel/dashboardc2.jpg'),
          AssetImage('images/Carousel/dashboardc6.jpg'),
        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 500),
      ),
    );

    return Scaffold(

      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('TOURISTAAN'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
              })
        ],
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            HEADER OF DRAWER
            new UserAccountsDrawerHeader(
              accountName: Text('MaNi'),
              accountEmail: Text('King78620@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ) ,
              decoration: new BoxDecoration(
                  color: Colors.black
              ),
            ),

//            BODY of the drawer

            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home, color: Colors.redAccent,),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new allProducts()));
              },
              child: ListTile(
                title: Text('View Packages'),
                leading: Icon(Icons.local_offer, color: Colors.redAccent,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person, color: Colors.redAccent,),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
              },
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.redAccent,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard, color: Colors.redAccent,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite, color: Colors.redAccent,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new Login()));
              },
              child: ListTile(
                title: Text('Log-Out'),
                leading: Icon(Icons.exit_to_app, color: Colors.blueGrey,),
              ),
            ),

            Divider(),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blueGrey,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.blue,),
              ),
            ),


          ],
        ),
      ),

//      Carousel.

//
      body: new ListView(
        children: <Widget>[
          image_carousel,
//          Padding Widget
//      ************BODY OF THE PAGE*************
          Divider(),
//        ***********CATEGORIES*******************
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),),),


//          Horizontal List view begins here
          HorizontalList(),
          Divider(),

//      **************RECENT PACKAGES*************

          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text("Recent Packages",
              style: TextStyle(fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),),),
//          grid View
          Container(
            height: 320.0,
            child: Products(),
          ),



        ],
      ),
    );
  }
}
