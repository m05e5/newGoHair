import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/pages/front/home_c.dart';
import 'package:provider/provider.dart';
import 'package:go_hair/app/welcome.dart';

class Authentificated{
  String id;

  Authentificated({this.id});
}

class Coiffeur{
  String name;
  int phone;
  String email;

  Coiffeur({this.name, this.phone, this.email});
}

class StreamProviderAuth{
  final FirebaseAuth _auth_C = FirebaseAuth.instance;

  //Creation d'un objet utilisateur provenant de firebase
  Authentificated authentificatedFromFirebase(FirebaseUser coiffeur){
    return coiffeur != null ? Authentificated(id: coiffeur.uid) : null;
  }

  //Diffusion de l'authentification de l'utilisateur
  Stream<Authentificated> get coiffeurs {
    return _auth_C.onAuthStateChanged.map(authentificatedFromFirebase);
  }

}

class Passerelle extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final coiffeur = Provider.of<Authentificated>(context);

    // si l'utilisateur existe on le redirige vers la page d'acceuil sinon vers le login
    if(coiffeur == null){
      //vers welcome
      return WelcomePage();
    }else{
      //vers home
      return FrontHomePageCoiffeur();
    }

  }
}

class GetCurrentCoiffeurDatas{
  String id;
  GetCurrentCoiffeurDatas({this.id});

  //La reference de la collection de l'utilisateur finale
  final CollectionReference coiffeurCollection = Firestore.instance.collection('Coiffeurs');

  Coiffeur coiffeurDataSnapshot(DocumentSnapshot snapshot){
    return Coiffeur(
        name: snapshot['name'],
        email: snapshot['email'],
        phone: snapshot['phone'],
    );
  }

  //Obtenir les données utilisateurs en stream
Stream<Coiffeur> get coiffeurData{
    return coiffeurCollection.document(id).snapshots()
        .map(coiffeurDataSnapshot);
}
}