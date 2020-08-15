import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/app/afficher_RDV_C.dart';
import 'package:go_hair/constants/loading.dart';
import 'package:go_hair/pages/auth/isAuthenticated_C.dart';
import 'package:go_hair/pages/auth/prendreRDV.dart';
import 'package:go_hair/pages/auth/settings.dart';
import 'package:go_hair/pages/users/clients.dart';
import 'package:provider/provider.dart';

class FrontHomePageCoiffeur extends StatefulWidget {
  FrontHomePageCoiffeur({Key key}) : super(key: key);
  final String title = 'Connexion';

  @override
  _FrontHomePageCoiffeurState createState() => _FrontHomePageCoiffeurState();
}

class _FrontHomePageCoiffeurState extends State<FrontHomePageCoiffeur> {

  String name;
  int phone;
  String email;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

        final coiffeur = Provider.of<Authentificated>(context);
    final height = MediaQuery.of(context).size.height;

    GetCurrentCoiffeurDatas(id: coiffeur.id).coiffeurData.forEach((snapshot) {
      this.name = snapshot.name;
      this.phone = snapshot.phone;
      this.email = snapshot.email;
    });
    return Scaffold(
    appBar: AppBar(
        title: Text('coiffeur'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
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
              accountName:new Text("moses"),//this.name),
              accountEmail:new Text("moses"),//this.email),
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
              
              child: Afficher_RDV_C(),
            )
            
          ],
        ),
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
