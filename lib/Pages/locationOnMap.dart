import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:collection';


class GMap extends StatefulWidget {
  final gmap_lat ;
  final gmap_long;
  final gmap_name;
  GMap(
  {
    this.gmap_name,
    this.gmap_lat,
    this.gmap_long
}
      );
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller){
  _mapController = controller;

  setState(() {
    _markers.add(Marker(markerId: MarkerId("0"),
    position: LatLng(widget.gmap_lat,widget.gmap_long),
        infoWindow: InfoWindow(title: widget.gmap_name, snippet: "A Journey with TOURISTAAN")
    ));
  }

  );
  setMapStyle();

  }
  void setMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString("assets/mapsstyle.json");
    _mapController.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Destination on Map"),
      ),

      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
            target: LatLng(widget.gmap_lat,widget.gmap_long),
            zoom: 12,
          ),
          markers: _markers,
            myLocationEnabled: true,
          ),
          Container(
          alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text("TOURSITAAN",style: TextStyle(decoration: TextDecoration.underline,fontSize: 20.0,
            fontStyle: FontStyle.italic),),
          )
        ],
      ),

    );
  }
}
