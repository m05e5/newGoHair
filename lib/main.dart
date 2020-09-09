import 'package:flutter/material.dart';
import 'package:go_hair/models/appointment.dart';
import 'package:go_hair/models/category.dart';
import 'package:go_hair/models/fidelity.dart';
import 'package:go_hair/models/hair_style.dart';
import 'package:go_hair/models/shop.dart';
import 'package:go_hair/pages/auth/isAuthenticated.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:provider/provider.dart';
void main(){
  Mappable.factories = {
    Appointment : () => Appointment(),
    Category : () => Category(),
    Fidelity : () => Fidelity(),
    HairStyle : () => HairStyle(),
    Shop : () => Shop(),
    User : () => User(),
  };
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Authentificated>.value(
      value: StreamProviderAuth().users,
      child: MaterialApp(
        title: 'Go Hair',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,

        ),
        debugShowCheckedModeBanner: false,

        home: Passerelle(),
      ),
    );
  }
}