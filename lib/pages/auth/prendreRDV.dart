import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/constants/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_hair/models/appointment.dart';
import 'package:go_hair/models/shop.dart';
import 'package:go_hair/pages/auth/cathalogue.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:go_hair/pages/front/home.dart';
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
  var newList = [
    'Obama Fashon',
    'Le claire',
    'shine fashon',
    'soft hair',
    'ivan coiffure'
  ];
  
  final _formKey = GlobalKey<FormState>();
  String clientName;
  String clientPhone;
  String userId;
  String shopId;
  String barberId;
  String hairStyleId;
  String date;
  String time;
  String detail;
  var toto;
  var selectedsalon;
  var salonList = [];
  Map<String, String> mapList = {
    
  };

  Future<Null> getSalons() async{
    CollectionReference ref = Firestore.instance.collection(Shop.table_name);
    QuerySnapshot snapshot = await ref.getDocuments();
    snapshot.documents.forEach((element) {
      setState(() {
        salonList.add(element[Shop.label_name]);
        mapList[element[Shop.label_id]] = element[Shop.label_name];
      });
    });
  }

  FormField<String> dropDown(){
    return FormField<String>(builder: (FormFieldState<String> state){
      return InputDecorator(
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.redAccent),
          hintText: 'Salon de coiffure',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0)
          )
        ),
        isEmpty: selectedsalon == null,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedsalon,
            isDense: true,
            items: mapList.keys.map((key){
              return DropdownMenuItem<String>(
                value: key,
                child: Text(mapList[key])
              );
            }).toList(),
            onChanged: (String newValue){
              setState(() {
                print(newValue);
                shopId = newValue;
                selectedsalon = newValue;
                state.didChange(newValue);
              });
            }
          ),
        ),
      );
    },);
  }

  @override
  void initState() {
    getSalons();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar:   AppBar(
        title: Text("Nouveaux RDV", style: TextStyle(color: Colors.white),),
      ),
          body: Container(
            child: Form(
              key:_formKey,
              autovalidate: true, 
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
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
            clientName = value;
          });
         },
       ),

 //stdu0664




    
                SizedBox(height: 15.0),
                   dropDown(),

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
            this.date = "${date.day}/${date.month}/${date.year} ${time.hour}:${time.minute}";
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
              clientPhone = value;
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
              detail = value;
            },
          ),


          SizedBox(height: 20.0),

          InkWell(
        onTap: (){
          saveAppointement();
        },
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
                 
                ],
              ),
            ),
          ),
    );
  }

  saveAppointement() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    CollectionReference reference = Firestore.instance.collection(Appointment.table_name);
    reference.document().setData({
      Appointment.label_id : reference.document().documentID,
      Appointment.label_shop_id : shopId,
      Appointment.label_user_id : user.uid,
      Appointment.label_client_name : clientName,
      Appointment.label_client_phone : clientPhone,
      Appointment.label_date : date,
      Appointment.label_time: time,
      Appointment.label_details : detail,
      
    });
     Navigator.push(context, MaterialPageRoute(builder: (context)=>new FrontHomePage()));
  }
}
        
      