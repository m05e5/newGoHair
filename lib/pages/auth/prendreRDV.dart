import 'package:flutter/material.dart';
import 'package:go_hair/constants/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_hair/pages/auth/cathalogue.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class PrendreRDV extends StatefulWidget {
  @override
  _PrendreRDVState createState() => _PrendreRDVState();
}

class _PrendreRDVState extends State<PrendreRDV> {
final format = DateFormat("yyyy-MM-dd HH:mm");

  var selectedValue;
  List<String> _test = <String>  [
    'Obama Fashon',
    'Le claire',
    'shine fashon',
    'soft hair',
    'ivan coiffure'
  ];
  
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _iduser;
  int _idsalon;
  int _idcoiffeur;
  DateTime dat;
  String description;
  var toto;
  var selectedsalon;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        title: Text("Nouveaux RDV", style: TextStyle(color: Colors.white),),
      ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key:_formKey,
              autovalidate: true, 
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                children: <Widget>[
                   SizedBox(height: 15.0),

  TextFormField(
            // controller: _emailController,
            // validator: _validateEmail,
         keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Nom",
          border: OutlineInputBorder(),
        ),
        onChanged: (String value) {
          setState(() {
            // _email = value;
          });
         },
       ),

 




    
                SizedBox(height: 15.0),
                   DropdownButton(
                     items: _test.map((value) => DropdownMenuItem(
                       
                     child: Text(
                       value,
                       style: TextStyle(color: Colors.orange),
                     ),
                     value: value,
                     )).toList(),
                      onChanged: (selectedAccountType){
                        print('$selectedAccountType');
                        setState(() {
                          toto = selectedAccountType;
                        });
                      },
                     value: toto,
                     isExpanded: true,
                     hint: Text('choisisez un salon'),
                      ),

 SizedBox(height: 15.0),

                   TextFormField(
            // controller: _emailController,
            // validator: _validateEmail,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "coiffure",
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() {
                // _email = value;
              });
            },
          ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 120.0, 0.0),
            child: InkWell(
      onTap: () {
         showDialog(context: context,
         builder: (context){
               return new AlertDialog(
                  title: new Text("choisisez votre coiffure"),
                  content: new Cathalogue(),
               );
         }
         );
      },
      child: Container(
        width: MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
             
              color: Colors.orange),
        child: Text(
            'cathalogue',
            style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ),
          ),







SizedBox(height: 15.0),


Column(children: <Widget>[
      
      DateTimeField(
         decoration: InputDecoration(
           labelText: "Date du rendezvous",
           border: OutlineInputBorder(),
        ),
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]),

SizedBox(height: 15.0),
              TextFormField(

            // controller: _emailController,
            // validator: _validateEmail,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Contact",
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() {
                // _email = value;
              });
            },
          ),


SizedBox(height: 15.0),
              TextFormField(
                minLines: 4,
                maxLines: null,
            // controller: _emailController,
            // validator: _validateEmail,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Description de coiffure(optionel)",
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() {
                // _email = value;
              });
            },
          ),


          SizedBox(height: 20.0),

          InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
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
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            "Envoyer",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )

    )












































































                      // StreamBuilder<QuerySnapshot>(
                      //   stream: Firestore.instance.collection("coiffeurs").snapshots(),
                      //   builder: (context, snapshot){
                      //     if(!snapshot.hasData){
                      //       Text("loading");
                      //     }
                      //     else{
                      //       List<DropdownMenuItem> salon = [];
                      //       for(int i=0; i>snapshot.data.documents.length ; i++){
                      //        DocumentSnapshot snap = snapshot.data.documents[i]; 
                      //         salon.add(
                      //             DropdownMenuItem(
                      //               child: Text(
                      //                 snap.documentID,
                      //                 style: TextStyle(color: Colors.orange),
                      //               ),
                      //               value: "${snap.documentID}",
                      //               ),
                      //         );
                      //       }
                      //       return Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: <Widget>[
                      //        DropdownButton(
                      //          items: salon, 
                      //          onChanged: (lesalon){
                      //           //  final snackBar = SnackBar(
                      //           //    content: 
                      //           //    Text('the selected saloon is $lesalon', style: TextStyle(color: Colors.orange)),
                      //           //  );
                      //           //  Scaffold.of(context).showSnackBar(snackBar);
                      //            setState(() {
                      //              selectedsalon = lesalon; 
                      //            });
                      //          },
                      //          value: selectedsalon,
                      //          isExpanded: true,
                      //          hint: new Text("Choose your saloon"),
                      //          )
                      //       ],
                      //       );
                      //     }
                      //   }
                        
                      //   ),
            //            StreamBuilder<QuerySnapshot>(
            //   stream: Firestore.instance.collection('coiffure').snapshots(),
            //   builder: (context, snapshot){
            //     if(!snapshot.hasData){
            //      return Text('Loading...');
            //     }
            //     else{
            //           List<DropdownMenuItem> salon = [];
            //                 for(int i=0; i>snapshot.data.documents.length ; i++){
            //                  DocumentSnapshot snap = snapshot.data.documents[i]; 
            //                   salon.add(
            //                       DropdownMenuItem(
                                    
            //                         child: Text(
            //                           snap.documentID,
                                      
            //                           style: TextStyle(color: Colors.orange),
            //                         ),
            //                         value: "${snap.documentID}",
            //                         ),
            //                   );
            //                   print(snap.documentID);
                    
 
            //       }
                  
               
            //         return Column(
                       
            //           children: <Widget>[ 
            //              SizedBox(height: 30.0,),
            //             DropdownButton(
            //             items:salon,
            //              onChanged: (coiffurevalue){
            //                final snackbar = SnackBar(
            //                  content: 
            //                  Text('$coiffurevalue', style: TextStyle(color: Colors.orange),),
            //                  );
            //                  Scaffold.of(context).showSnackBar(snackbar);
            //                  setState(() {
            //                    selectedValue = coiffurevalue;   
            //                  });
            //              },
            //              value: selectedValue,
            //              isExpanded:true,
            //              hint: new Text('choisisez un coiffeur',
            //              style: TextStyle(color: Colors.orange)
            //              ),
            //       ),
            //            SizedBox(height: 10.0,),
            //        DropdownButton(
            //             items:salon,
            //              onChanged: (coiffurevalue){
            //                final snackbar = SnackBar(
            //                  content: 
            //                  Text('$coiffurevalue', style: TextStyle(color: Colors.orange),),
            //                  );
            //                  Scaffold.of(context).showSnackBar(snackbar);
            //                  setState(() {
            //                    selectedValue = coiffurevalue;   
            //                  });
            //              },
            //              value: selectedValue,
            //              isExpanded:true,
            //              hint: new Text('choisisez un salon',
            //              style: TextStyle(color: Colors.orange)
            //              ),
            //       ),
            //           ],
            //         );

                  
         
               
            //     }
            //   },
            // ),
                        
                ],
              ),
            ),
          ),
    );
  }
}








              
      //   key: _formKey,
      //   child: Column(children: <Widget>[
      //       Text('  ',
      //       style: TextStyle(fontSize: 18.0),
      //       ),
           

         

      //       //dropdown
      //       StreamBuilder<QuerySnapshot>(
      //         stream: Firestore.instance.collection('coiffure').snapshots(),
      //         builder: (context, snapshot){
      //           if(!snapshot.hasData){
      //             Text('Loading...');
      //           }
      //           else{
      //             List<DropdownMenuItem> coiffeurItem=[];
      //             for (int i=0; i>snapshot.data.documents.length; i++){
      //               DocumentSnapshot snap = snapshot.data.documents[i];
      //               coiffeurItem.add(
      //                 DropdownMenuItem(
      //                   child:Text(
      //                     snap.documentID,
      //                     style: TextStyle(color: Colors.orange)
      //                   ) ,
      //                   value: "${ snap.documentID}",
      //                   ),
      //               );
 
      //             }
               
      //               return Column(
      //                 children: <Widget>[
      //                    SizedBox(height: 30.0,),
      //                   DropdownButton(
      //                   items:coiffeurItem,
      //                    onChanged: (coiffurevalue){
      //                      final snackbar = SnackBar(
      //                        content: 
      //                        Text('$coiffurevalue', style: TextStyle(color: Colors.orange),),
      //                        );
      //                        Scaffold.of(context).showSnackBar(snackbar);
      //                        setState(() {
      //                          selectedValue = coiffurevalue;   
      //                        });
      //                    },
      //                    value: selectedValue,
      //                    isExpanded:true,
      //                    hint: new Text('choisisez un coiffeur',
      //                    style: TextStyle(color: Colors.orange)
      //                    ),
      //             ),

      //                  SizedBox(height: 10.0,),
      //              DropdownButton(
      //                   items:coiffeurItem,
      //                    onChanged: (coiffurevalue){
      //                      final snackbar = SnackBar(
      //                        content: 
      //                        Text('$coiffurevalue', style: TextStyle(color: Colors.orange),),
      //                        );
      //                        Scaffold.of(context).showSnackBar(snackbar);
      //                        setState(() {
      //                          selectedValue = coiffurevalue;   
      //                        });
      //                    },
      //                    value: selectedValue,
      //                    isExpanded:true,
      //                    hint: new Text('choisisez un salon',
      //                    style: TextStyle(color: Colors.orange)
      //                    ),
      //             ),
      //                 ],
      //               );

                  
         
               
      //           }
      //         },
      //       ),
      //        SizedBox(height: 10.0,),
      //                   InkWell(
      //                     onTap: () {
      //   showDialog(context: context,
        
      //         builder: ( context){
      //           return new AlertDialog(
                  
      //             title: new Text("faite votre choix"),
      //             content: new Row(children: <Widget>[
                    
      //                 new InkWell(onTap: (){
                      
      //                 },
                      
      //                 child: Container(
      //                    padding: EdgeInsets.all(5),
      //                   decoration: BoxDecoration(
      //                    borderRadius: BorderRadius.all(Radius.circular(5)),
      //                    border: Border.all(color: Colors.white, width: 2),
      //                    boxShadow: <BoxShadow>[
      //         BoxShadow(
      //             color: Color(0xffdf8e33).withAlpha(100),
      //             offset: Offset(2, 4),
      //             blurRadius: 8,
      //             spreadRadius: 2)
      //       ],
      //                  ),
      //                   child: new Text("Coiffeur",
      //                    style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
      //                   ),
      //                 ),),
      //                 new MaterialButton(onPressed: (){
                        
                  
        
      //                 },

      //                 child: Container(
      //                    padding: EdgeInsets.all(5),
      //                    decoration: BoxDecoration(
      //                    borderRadius: BorderRadius.all(Radius.circular(5)),
      //                    border: Border.all(color: Colors.white, width: 2),
      //                    boxShadow: <BoxShadow>[
      //         BoxShadow(
      //             color: Color(0xffdf8e33).withAlpha(100),
      //             offset: Offset(2, 4),
      //             blurRadius: 8,
      //             spreadRadius: 2)
      //       ],
      //                  ),
      //                   child: new Text("Client",
      //                    style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
      //                    ),
      //                 ),)
      //             ]),
      //             actions: <Widget>[
                    
      //                 new InkWell(onTap: (){
      //                   Navigator.of(context).pop(context); 
      //                 },
      //                 child: new Text("close",
      //                  style: TextStyle(fontSize: 20, color: Colors.red),
      //                 ),)
                  
      //               ],
      //           );
      //         }
      //         );
      //   // Navigator.push(
      //   //     context, MaterialPageRoute(builder: (context) => RegisterPage()));
        
      // },
      //                 child: TextFormField(
      //       decoration:InputDecoration(
      //         labelText: "coiffure",
      //         border: OutlineInputBorder(),
      //       ),
      //       validator: (val) => val.isEmpty ? 'svp entrer le nom de votre cioffure' : null,
      //       onChanged: (val) => setState(() => _name = val),
      //       ),
      //                   ),
      //       SizedBox(height: 30.0,),

      //       //slider
      //       RaisedButton(
      //         color: Colors.orange,
      //         child: Text('Envoyer',
      //         style: TextStyle(color: Colors.white),
      //         ),
      //         onPressed: () async{}
      //       )
      //   ],),
        
      