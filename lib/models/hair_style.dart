import 'package:object_mapper/object_mapper.dart';

class HairStyle with Mappable{
  String id;
  String name;
  String price;
  String photoUrl;
  String categoryId;
  String shopId;

  HairStyle({this.id, this.name, this.price, this.photoUrl, this.categoryId, this.shopId});

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('name', name, (v) => name = v);
    map('price', price, (v) => price = v);
    map('photo_url', photoUrl, (v) => photoUrl = v);
    map('category_id', categoryId, (v) => categoryId = v);
    map('shop_id', shopId, (v) => shopId = v);
  }


}