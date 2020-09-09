class Appointment{
  String id;
  String userId;
  String shopId;
  String barberId;
  String hairStyleId;
  String phone;
  String name;
  String date;
  String time;
  String details;

  static final table_name = "appointment";
  static final label_id = "id";
  static final label_user_id = "user_id";
  static final label_shop_id = "shop_id";
  static final label_barber_id = "barber_id";
  static final label_hair_style_id = "haire_style_id";
  static final label_client_name = "client_name";
  static final label_client_phone = "client_phone";
  static final label_date = "date";
  static final label_time = "time";
  static final label_details = "details";

  Appointment({this.id, this.userId, this.shopId, this.barberId, this.hairStyleId, this.phone, this.name, this.date, this.time, this.details});

}