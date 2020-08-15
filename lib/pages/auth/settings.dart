import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body:  InkWell(
                onTap: _delet_Account,
                              child: ListTile(
                  title: Text('suprimerson compte'),
                  leading: Icon(Icons.close, 
                  color: Colors.red,),
                ),
              ),
    );
  }
  void _delet_Account() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    user.delete();

  }
  
  
}
class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future deleteuser() {
    return userCollection.document(uid).delete();
  }
}

