import 'package:flutter/material.dart';
import 'main.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'cart.dart';
import 'home.dart';
import 'locationOnMap.dart';
class PackageDetails extends StatefulWidget {

//  *************** VARIBALES ********
  final package_detail_name;
  final package_detail_picture1;
  final package_detail_picture2;
  final package_detail_picture3;
  final package_detail_ppp;
  final package_detail_location;
  final package_detail_lat;
  final package_detail_lng;

//  *********CONSTRUCTOR************
  PackageDetails(
  {
    this.package_detail_location,
    this.package_detail_picture1,
    this.package_detail_name,
    this.package_detail_picture2,
    this.package_detail_picture3,
    this.package_detail_ppp,
    this.package_detail_lat,
    this.package_detail_lng,
  });


  @override
  _PackageDetailsState createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      *********APP BARRR***********
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));

            },
            child: Text('TOURISTAAN')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),

        ],
      ),

//      ***********BODY OF THE PAGE**********
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
//                child: Image.asset(widget.package_detail_picture1),

                child: new Carousel(
                  boxFit: BoxFit.cover,
                  images: [
                    AssetImage(widget.package_detail_picture1),
                    AssetImage(widget.package_detail_picture2),
                    AssetImage(widget.package_detail_picture3),

                  ],
                  autoplay: true,
                  dotSize: 4.0,
                  indicatorBgPadding: 4.0,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 500),
                ),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    widget.package_detail_name,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          "${widget.package_detail_location}",
                          style: TextStyle(
                              color: Colors.grey,
                              ),
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          "\PKR-${widget.package_detail_ppp}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),


//          *******The First button*********
          Row(
            children: <Widget>[
//              *******The Size Button********
              Expanded(
                child: MaterialButton(
                  onPressed: () {
//                    *******ALERT DIAGLOGUE*****
                    showDialog(context: context,
                        builder: (context){
                          return new AlertDialog(
                            title: new Text("Call Agency"),
                            content: new Text('VOIP Call module under construction'),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("close"),)
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Icon(Icons.call,color: Colors.deepPurple,),
                      ),
//                      Expanded(
//                        child: new Icon(Icons.call),
//                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context,
                        builder: (context){
                          return new AlertDialog(
                            title: new Text('Chat'),
                            content: new Text("ChatBox under construction"),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("close"),)
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Icon(Icons.message,color: Colors.deepPurple,),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {

                    showDialog(context: context,
                        builder: (context){
                          return new AlertDialog(
                            title: new Text('Play in VR'),
                            content: new Text("VR video Under-construction"),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("close"),)
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Icon(Icons.video_library,color: Colors.deepPurple,),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => new GMap(
                          gmap_name: widget.package_detail_name,
                          gmap_lat: widget.package_detail_lat,
                          gmap_long: widget.package_detail_lng,
                        )));
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Icon(Icons.location_on,color: Colors.deepPurple,),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //          *******The Second button *******
          Row(
            children: <Widget>[
//              *******The PLACE ORDER Button********
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context,
                        builder: (context){
                          return new AlertDialog(
                            title: new Text('Giddy-up for this Package'),
                            content: new Text("Ordering Module Under-construction"),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text("close"),)
                            ],
                          );
                        });
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                  child: new Text("Place Order!"),
                ),
              ),
              new IconButton(icon: Icon(Icons.add_shopping_cart),color: Colors.red,onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
              },),
              new IconButton(icon: Icon(Icons.favorite_border),color: Colors.red,onPressed: (){},),


            ],
          ),
          Divider(color: Colors.red,),
          new ListTile(
            title: new Text("Product Details"),
            subtitle: new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets",
              style: TextStyle(fontSize: 20 ),),
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0 , 5.0, 5.0),
                child: new Text("Destination",style: TextStyle(color: Colors.grey),),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.package_detail_name),
              ),
            ],

          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0 , 5.0, 5.0),
                child: new Text("Price per person",style: TextStyle(color: Colors.grey),),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("\Pkr-${widget.package_detail_ppp}"),
              )


            ],
//            ********ADD CONDITION**********
          ),new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0 , 5.0, 5.0),
                child: new Text("Area :",style: TextStyle(color: Colors.grey),),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.package_detail_location}",textAlign: TextAlign.end,),
              ),


            ],

          )
        ],
      ),


    );
  }
}
