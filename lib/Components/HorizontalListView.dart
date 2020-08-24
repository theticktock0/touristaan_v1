import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget> [
//            Calling category with different icons and captions
            Category(
              image_location: "images/Categories/hiking.png",
              image_caption: "hiking",
            ),

            Category(
              image_location: "images/Categories/hills.png",
              image_caption: "hills.png",
            ),
            Category(
              image_location: "images/Categories/snowy.png",
              image_caption: "snowy.png",
            ),Category(
              image_location: "images/Categories/waterfall.png",
              image_caption: "Waterfall",
            ),
            Category(
              image_location: "images/Categories/lake1.png",
              image_caption: "lake",
            ),
            Category(
              image_location: "images/Categories/lake2.png",
              image_caption: "River",
            ),





          ]
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Category({
    this.image_location,this.image_caption
  });

  @override
  Widget build(BuildContext context) {
    return Padding (padding: const EdgeInsets.all(2.0),
      child: InkWell(onTap: (){},
        child: Container(
          width: 100,
          child: ListTile(
            title: Image.asset(image_location,
              width: 100.0,
              height: 80.0,),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}




