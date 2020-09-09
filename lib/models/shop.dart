import 'package:object_mapper/object_mapper.dart';

class Shop with Mappable{
  String id;
  String userId;
  String name;
  String email;
  String phone;
  String address;
  String imageUrl;
  String averageRate;
  String voteCount;

  static final table_name = "shop";
  static final label_id = "id";
  static final label_name = "name";
  static final label_email = "email";
  static final label_phone = "phone";
  static final label_user_id = "user_id";
  static final label_image_url = "image_url";

  Shop({this.id, this.userId, this.name, this.email, this.phone, this.address, this.imageUrl});

  @override
  void mapping(Mapper map) {
    map('id', id, (v) => id = v);
    map('user_id', userId, (v) => userId = v);
    map('name', name, (v) => name = v);
    map('email', email, (v) => email = v);
    map('phone', phone, (v) => phone = v);
    map('address', address, (v) => address = v);
    map('image_url', imageUrl, (v) => imageUrl = v);
    map('average_rate', averageRate, (v) => averageRate = v);
    map('vote_count', voteCount, (v) => voteCount = v);
  }

  @override
  String toString() {
    return 'Shop{id: $id, userId: $userId, name: $name, email: $email, phone: $phone, address: $address, imageUrl: $imageUrl}';
  }
}