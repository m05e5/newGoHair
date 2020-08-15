import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/app/afficher_RDV_C.dart';
import 'package:go_hair/app/afficher_user.dart';
import 'package:go_hair/app/welcome.dart';
import 'package:go_hair/constants/loading.dart';
import 'package:go_hair/pages/auth/isAuthenticated.dart';
import 'package:go_hair/pages/auth/prendreRDV.dart';
import 'package:go_hair/pages/auth/settings.dart';
import 'package:go_hair/pages/users/clients.dart';
import 'package:provider/provider.dart';


class FrontHomePage extends StatefulWidget {
  FrontHomePage({Key key}) : super(key: key);
  final String title = 'Connexion';

  @override
  _FrontHomePageState createState() => _FrontHomePageState();
}

class _FrontHomePageState extends State<FrontHomePage> {

  String name;
  int phone;
  String email;
  User user;

  bool isLoading = false; 

  setUserInfo() async{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      if(user != null){
        getCurrentUserInfo(user.uid);
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return WelcomePage();
        })).then((value) => Navigator.pop(context));
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
    // void _showSettingsPannel(){
    //   showModalBottomSheet(context: context, builder: (context){
    //     return Container(
    //       padding:EdgeInsets.symmetric(vertical: 20.0, horizontal: 70.0,) ,
    //       child: PrendreRDV(),
    //     );
    //   });
    // }

    final user = Provider.of<Authentificated>(context);
    final height = MediaQuery.of(context).size.height; 

    GetCurrentUserDatas(id: user.id).userData.forEach((snapshot) {
      setState(() {
        this.name = snapshot.name;
        this.phone = snapshot.phone;
        this.email = snapshot.email;
      });
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceuil'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setUserInfo();
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: (){},
          ),
        ],
      ),
    

      
      drawer:new Drawer(
       child: new ListView(
         children: <Widget>[
//          header
            new UserAccountsDrawerHeader(
              accountName:new Text(this.name != null ? this.name : 'Loading...'),
              accountEmail:new Text(this.email != null ? this.email : 'Loading...'), 
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                  ) ,
                ),
                decoration: new BoxDecoration(
                  color:  Colors.orange
                ),  
              ),
//              body
              InkWell(
                onTap: (){},
                              child: ListTile(
                  title: Text('Home Page'),
                  leading: Icon(Icons.home, color: Colors.orange,),
                ),
              ),

               InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>new ClientPage()));
                },
                              child: ListTile(
                  title: Text('mon compte'),
                  leading: Icon(Icons.person, color: Colors.orange,),
                ),
              ),

               InkWell(
                onTap: (){},
                              child: ListTile(
                  title: Text('mes commande'),
                  leading: Icon(Icons.shopping_basket,
                   color: Colors.orange,),
                ),
              ),


           

               InkWell(
                onTap: (){},
                              child: ListTile(
                  title: Text('Fidelité'),
                  leading: Icon(Icons.favorite, 
                  color: Colors.orange,),
                ),
              ),
                SizedBox(height: 50.0,),

          Divider(),

           InkWell(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>new Settings()));
                },
                              child: ListTile(
                  title: Text('parametre'),
                  leading: Icon(Icons.settings, 
                  color: Colors.grey,),
                ),
              ),

            InkWell(
                onTap: (){},
                              child: ListTile(
                  title: Text('a propos de nous '),
                  leading: Icon(Icons.help, 
                  color: Colors.grey,),
                ),
              ),
             InkWell(
                onTap: onLogout,
                              child: ListTile(
                  title: Text('deconnexion'),
                  leading: Icon(Icons.power_settings_new, 
                  color: Colors.grey,),
                ),
              ),
       
       
         ],
       ),
     ) ,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    (this.isLoading == true) ? SimpleLoading()
                        : Text('Liste de mes Rendezvous'),
                  ],
                ),
              ),
            ),
            Container(
              
              child:Afficher_RDV_C(),
            )
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>new PrendreRDV())),
      ),
    );
  }

  onLogout() async {
    setState((){
      this.isLoading = true;
    });

    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();

    print('Successs');
    setState((){
      this.isLoading = false;
    });

  }
}
