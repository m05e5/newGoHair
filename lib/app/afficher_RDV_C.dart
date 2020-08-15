
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class Afficher_RDV_C extends StatefulWidget {
  @override
  _Afficher_RDV_CState createState() => _Afficher_RDV_CState();
}

// ignore: camel_case_types
class _Afficher_RDV_CState extends State<Afficher_RDV_C> {
  final CollectionReference rdvCollection = Firestore.instance.collection('RDV');



  @override
  Widget build(BuildContext context) {
    return Container(
      child:StreamBuilder(
        stream: Firestore.instance.collection('RDV').snapshots(),
        builder: (context, snapshort){
          if(!snapshort.hasData){
            return Text("Lauding data... please wait ..");
          }
          
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
                        "Name: " + snapshort.data.documents[index]['NomClient'],
                        style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 15,
                          ),
                      ),
                      Text(
                        "Nom de la coiffure: "+ snapshort.data.documents[index]['NomCoiffure'],
                        style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 15,
                          ),
                        ),
                        Text("description: " +snapshort.data.documents[index]['description'], 
                      style: TextStyle(color:Colors.grey),
                      ),
                      Text("phone: " +snapshort.data.documents[index]['Tel'].toString(), 
                      style: TextStyle(color:Colors.black),
                      ),
                     
                      Row(children: <Widget>[ 
                        SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                          onTap: (){},
         child: Container(
          width: MediaQuery.of(context).size.width/3,
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.green, Colors.greenAccent])),
          child: Text(
            'Accepter',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )

    ),
                        ),
    SizedBox(width: 20),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(  
   onTap: (){},
         child: Container(
            width: MediaQuery.of(context).size.width/3,
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)), 
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.red, Colors.redAccent])),
            child: Text(
              'Refuser',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )

      ),
    ),
    SizedBox(width: 20),
                      ],)
                      
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