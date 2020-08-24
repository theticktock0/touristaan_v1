import 'package:flutter/material.dart';
import "package:touristaan_v1/Pages/product_details.dart";

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Darbar Mahal",
      "picture1": "images/Destinations/darbarmahal/darbarc1.jpg",
      "picture2": "images/Destinations/darbarmahal/darbarc2.jpg",
      "picture3":"images/Destinations/darbarmahal/darbarc3.jpg",
      "ppp": 15000,
      "Location" : "Bahawlpur",
      "lat": 29.3972,
      "long" : 71.6998,

    },
    {
      "name": "Hiran Minaar",
      "picture1": "images/Destinations/Hiran_minar/hiranc1.jpg",
      "picture2": "images/Destinations/Hiran_minar/hiranc2.jpg",
      "picture3":"images/Destinations/Hiran_minar/hiranc3.jpg",
      "ppp": 20000,
      "Location" : "Sheikhupura",
      "lat": 31.743056,
      "long" : 73.955194,
    },
    {
      "name": "Hunza",
      "picture1": "images/Destinations/hunza/hunza1.jpeg",
      "picture2": "images/Destinations/hunza/hunza2.jpg",
      "picture3":"images/Destinations/hunza/hunza3.jpg",
      "ppp": 15000,
      "Location" : "Gilgit-Baltistan",
      "lat": 36.316942,
      "long" : 74.6499,
    },
    {
      "name": "Makli Graveyard",
      "picture1": "images/Destinations/Makli/makli1.jpg",
      "picture2": "images/Destinations/Makli/makli2.jpeg",
      "picture3":"images/Destinations/Makli/makli3.jpg",
      "ppp": 25000,
      "Location" : "Thatta",
      "lat": 24.76,
      "long" : 67.902,
    },
    {
      "name": "Nathiya Gali",
      "picture1": "images/Destinations/Nathia/nathiac1.jpg",
      "picture2": "images/Destinations/Nathia/nathiac2.jpg",
      "picture3":"images/Destinations/Nathia/nathiac3.jpg",
      "ppp": 15000,
      "Location" : "Abbottabad, Khyber Pakhtunkhwa",
      "lat": 34.0729,
      "long" : 73.3812,
    },
    {
      "name": "Saif-ul-Malook",
      "picture1": "images/Destinations/Saiful_malok/saifc1.png",
      "picture2": "images/Destinations/Saiful_malok/saifc2.jpg",
      "picture3":"images/Destinations/Saiful_malok/saifc3.jpg",
      "ppp": 15000,
      "Location" : "Mansehra district",
      "lat": 34.876957,
      "long" : 73.694485,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ScrollPhysics(),
        itemCount: product_list.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
//
              package_name: product_list[index]["name"],
              package_picture1: product_list[index]["picture1"],
              package_picture2: product_list[index]["picture2"],
              package_picture3: product_list[index]["picture3"],
              package_ppp: product_list[index]["ppp"],
              package_location: product_list[index]["Location"],
              package_lat: product_list[index]["lat"],
              package_lng: product_list[index]["long"],

            ),
          );
        });
//    return Container();
  }
}

class Single_prod extends StatelessWidget {
  final package_name;
  final package_picture1;
  final package_picture2;
  final package_picture3;
  final package_ppp;
  final package_location;
  final package_lat;
  final package_lng;

  Single_prod(
      {
      this.package_location,
        this.package_name,
        this.package_picture1,
        this.package_picture2,
        this.package_picture3,
        this.package_ppp,
        this.package_lat,
        this.package_lng
});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text("xyz"),
          child: Material(
              child: InkWell(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new PackageDetails(
//        ****************  here we are passing the value of the producct to the single prod detail page*********

                       package_detail_name: package_name,
                       package_detail_picture1 : package_picture1,
                       package_detail_picture2 :  package_picture2,
                       package_detail_picture3 :  package_picture3,
                       package_detail_ppp : package_ppp,
                       package_detail_location :  package_location,
                       package_detail_lat: package_lat,
                       package_detail_lng: package_lng,
//                        product_detail_name: product_name,
//                        product_detail_new_price: prod_price,
//                        product_detail_old_price: prod_old_price,
//                        product_detail_picture: product_picture,
                      ))),

                  child: GridTile(
                      footer: Container(
                        color: Colors.white70,
//                    OLD DEIGN HERE
//                        child: ListTile(
//                          leading: Text(
//                            product_name,
//                            style: TextStyle(fontWeight: FontWeight.bold),
//                          ),
//                          title: Text(
//                            "\$$prod_price",
//                            style: TextStyle(
//                                color: Colors.blueGrey,
//                                fontWeight: FontWeight.w800),
//                          ),
//                          subtitle: Text(
//                            "\$$prod_old_price",
//                            style: TextStyle(
//                                color: Colors.black54,
//                                fontWeight: FontWeight.w800,decoration: TextDecoration.lineThrough),
//                          ),
//                        ),
//                      new design from here

                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(package_name,style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            new Text("\$$package_ppp",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      child: Image.asset(
                        package_picture1,
                        fit: BoxFit.cover,
                      ))))),
    );
  }
}
