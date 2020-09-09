import 'package:object_mapper/object_mapper.dart';

class Fidelity with Mappable{
  String id;
  String point;
  String userId;
  String shopId;

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('point', point, (v) => point = v);
    map('user_id', userId, (v) => userId = v);
    map('shop_id', shopId, (v) => shopId = v);
  }
}