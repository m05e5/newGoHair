import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal, 
        children: <Widget>[
         Category(
           image_location: 'assets/catalogue/homme.jpg',
           image_caption:'Homme',
         ),

         Category(
           image_location: 'assets/catalogue/femme.jpg',
           image_caption:'Femme',
         ),

         Category(
           image_location: 'assets/catalogue/makeup.jpg',
           image_caption:'Makillage',
         ),

         Category(
           image_location: 'assets/catalogue/plus.jpg', 
           image_caption:'plus',
         ),


        ],
         ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
  this.image_caption, 
  this.image_location
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
      child: InkWell(onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
  
              ],
        ),
        width: 100.0,
              child: ListTile(
          title: Image.asset(image_location, 
          
          height: 70.0,
          ),
          subtitle:Container(
            alignment: Alignment.topCenter,
            child: Text(image_caption, style: new TextStyle(fontSize: 12.0),),
          )
        ),
      ),),
    );
  }
}