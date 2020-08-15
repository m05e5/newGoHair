import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_hair/pages/front/home.dart';
import 'package:go_hair/app/welcome.dart';

class Authentificated{
  String id;

  Authentificated({this.id});
}

class User{
  String id;
  String name;
  int phone;
  String email;

  User({this.id, this.name, this.phone, this.email});

}

class StreamProviderAuth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Creation d'un objet utilisateur provenant de firebase
  Authentificated authentificatedFromFirebase(FirebaseUser user){
    return user != null ? Authentificated(id: user.uid) : null;
  }

  //Diffusion de l'authentification de l'utilisateur
  Stream<Authentificated> get users {
    return _auth.onAuthStateChanged.map(authentificatedFromFirebase);
  }

}

class Passerelle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Authentificated>(context);

    // si l'utilisateur existe on le redirige vers la page d'acceuil sinon vers le login
    if(user == null){
      //vers welcome
      return WelcomePage();
    }else{
      //vers home
      return FrontHomePage();
    }

  }
}

class GetCurrentUserDatas{
  String id;
  GetCurrentUserDatas({this.id});

  //La reference de la collection de l'utilisateur finale
  final CollectionReference userCollection = Firestore.instance.collection('user');
  
  User userDataSnapshot (DocumentSnapshot snapshot) {
    return User(
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
    );
  }

  

  //Obtenir les données utilisateurs en stream
Stream<User> get userData {
    return userCollection.document(id).snapshots()
        .map(userDataSnapshot);
}
}