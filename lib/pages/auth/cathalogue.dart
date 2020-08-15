import 'package:flutter/material.dart';
import 'package:go_hair/pages/auth/upload.dart';

class Cathalogue extends StatefulWidget {
  @override
  _CathalogueState createState() => _CathalogueState();
}

class _CathalogueState extends State<Cathalogue> {
  var catha = [
    {
      "name": "rasta_long",
      "picture":  "assets/catalogue/rasta_long.jpg",
   
   },
    {
      "name": "rasta_court",
      "picture":  "assets/catalogue/rasta_court.jpg",
   
    },
     {
      "name": "afro",
      "picture":  "assets/catalogue/rasta_long.jpg",
   
    },
      {
      "name": "mesh",
      "picture":  "assets/catalogue/rasta_court.jpg",
   
    },
      {
      "name": "natte",
      "picture":  "assets/catalogue/rasta_long.jpg",
   
    },
      {
      "name": "dread lox",
      "picture":  "assets/catalogue/rasta_court.jpg",
   
    },
  
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
       itemCount: catha.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index){
           return Prod(
             service_name: catha[index]['name'],
             service_picture: catha[index]['picture'],
             
            
           );
           }
      
    );
  }
}

class Prod extends StatelessWidget {
  final service_name;
  final service_picture;

  Prod({
    this.service_name,
    this.service_picture,
  
  }); 
  
  void open(BuildContext context){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new Upload   ())).then((value) => Navigator.pop(context)  ); 
               
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: service_name,
         child: Material(
           child:InkWell(
            onTap: () => open(context),
             child: GridTile(
               footer: Container(
                  color: Colors.white,
                child:new Row(children: <Widget>[
                Expanded(
                  child: new Text(service_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                ),
               
              ],)
               ),
                
             child: Image.asset(service_picture,
             fit: BoxFit.cover),)
               ),
             ),
         )
         );
      
    
  }
}