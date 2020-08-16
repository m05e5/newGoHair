class Shop{
  String id;
  String userId;
  String name;
  String email;
  String phone;
  String address;

  static final table_name = "shop";
  static final label_id = "id";
  static final label_name = "name";
  static final label_email = "email";
  static final label_phone = "phone";
  static final label_user_id = "user_id";

  Shop({this.id, this.userId, this.name, this.email, this.phone, this.address});
}