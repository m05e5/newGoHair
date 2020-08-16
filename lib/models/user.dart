class User {
  String id;
  String name;
  String email;
  String phone;
  String role;
  String shopId;

  static final table_name = "user";
  static final label_id = "id";
  static final label_name = "name";
  static final label_email = "email";
  static final label_phone = "phone";
  static final label_role = "role";
  static final label_shop_id = "shop_id";

  User({this.id, this.name, this.email, this.phone, this.role, this.shopId});
}