import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_hair/pages/auth/isAuthenticated.dart';



class ClientPage extends StatefulWidget {
  ClientPage({Key key}) : super(key: key);
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  var bobo;
String name;
String phone;
String email;
User user;

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   setUserInfo() async{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if(user != null){
        getCurrentUserInfo(user.uid);
      }
    }

  Future<User> getCurrentUserInfo(String userId) async{
    CollectionReference ref = Firestore.instance.collection('user');
    QuerySnapshot snapshot = await ref.getDocuments();
    snapshot.documents.forEach((element) {
      print(userId);
      if(element['id'] == userId){
        user = new User(
          id: element['id'],
          email: element['email'],
          phone: element['phone'],
          name: element['name']
        );
        setState(() {
          this.name = user.name;
          this.email = user.email;
          this.phone = user.phone;
        });
      }
    });
    return user;
  }

    @override
  void initState() {
    setUserInfo();
    super.initState();
  }

 
  @override
  Widget build(BuildContext context) {
     Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.orange[40],
      appBar: AppBar(
        title: Text("Edit profile"),
      ) ,
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: <Widget>[
          SizedBox(height: 15.0),
          (orientation == Orientation.portrait)
                  ? Container(
                child: Image.asset("assets/undraw_barber_3uel_sur_vide.png"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),)
                  : Text(''),
                  SizedBox(height: 30,),
              
                   Text(
                     "Name",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 12,
                     ),
                     ),
                    Text(
                     user.name,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.bold
                     ),
                     ),

                     SizedBox(height: 10,),

                      Text(
                     "Email",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 12,
                     ),
                     ),
                    Text(
                     user.email,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.bold
                     ),
                     ),

                      SizedBox(height: 10,),

                      Text(
                     "Contact",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 12,
                     ),
                     ),
                    Text(
                     user.phone,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.bold
                     ),
                     ),
                
        ],),
      )
    );
  }
}