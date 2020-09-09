import 'package:flutter/material.dart';
import 'package:go_hair/models/category.dart';

class HorizontalList extends StatelessWidget {
  final List<Category> categories;

  HorizontalList(this.categories);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          Category c = categories[i];
          return CategoryWidget(
            image_caption: c.name,
            image_location: c.imageUrl,
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String image_location;
  final String image_caption;

  CategoryWidget({this.image_caption, this.image_location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[],
          ),
          width: 100.0,
          child: ListTile(
              title: image_location != null ? Image.network(
                image_location,
                height: 70.0,
              ) :
              Image.asset("assets/undraw_barber_3uel.png", height: 70,),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: new TextStyle(fontSize: 12.0),
                ),
              )),
        ),
      ),
    );
  }
}
