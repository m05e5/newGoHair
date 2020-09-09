import 'package:object_mapper/object_mapper.dart';

class Category with Mappable{
  String id;
  String name;
  String imageUrl;
  static String tableName = 'category';

  Category({this.id, this.name, this.imageUrl});

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('name', name, (v) => name = v);
    map('image_url', imageUrl, (v) => imageUrl = v);
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, imageUrl: $imageUrl}';
  }
}