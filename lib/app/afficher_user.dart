
import 'package:flutter/material.dart';
//firestor plug in
import 'package:cloud_firestore/cloud_firestore.dart';

class Affichier extends StatefulWidget {
  @override
  _AffichierState createState() => _AffichierState();
}

class _AffichierState extends State<Affichier> {
final CollectionReference userCollection = Firestore.instance.collection('users');

 

  @override
  Widget build(BuildContext context) {
    return Container(
      height:620.0,
      child:StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (context, snapshort){
          if(!snapshort.hasData){
            return Text("Lauding data... please wait ..");
          }
          // return Column(children: <Widget>[
          //   Text(snapshort.data.documents[0]['name']),
          //   Text(snapshort.data.documents[0]['email'].toString()),
          // ],);
          return new ListView.builder(
            shrinkWrap: true,
            itemCount: snapshort.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(
                        "Name: " + snapshort.data.documents[index]['name'],
                        style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 20.5,
                          ),
                      ),
                      Text(
                        "email: "+ snapshort.data.documents[index]['email'].toString(),
                        style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 20.5,
                          ),
                        ),
                      Text("phone: " +snapshort.data.documents[index]['phone'].toString(), 
                      style: TextStyle(color:Colors.blue),
                      ),
                      
                      ],
                  ),
                  ),
                );
            });
        }
        ),
     );
  }
}