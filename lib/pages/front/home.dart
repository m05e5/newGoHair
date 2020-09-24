import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/app/RDV/rdv.dart';
import 'package:go_hair/app/welcome.dart';
import 'package:go_hair/constants/loading.dart';
import 'package:go_hair/models/category.dart';
import 'package:go_hair/models/shop.dart';
import 'package:go_hair/pages/auth/isAuthenticated.dart';
import 'package:go_hair/pages/auth/settings.dart';
import 'package:go_hair/pages/front/cardAdv.dart';
import 'package:go_hair/pages/shop_detail.dart';
import 'package:go_hair/pages/users/clients.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'horizontalList.dart';
import 'package:floating_search_bar/floating_search_bar.dart';


class FrontHomePage extends StatefulWidget {
  FrontHomePage({Key key}) : super(key: key);
  final String title = 'Connexion';

  @override
  _FrontHomePageState createState() => _FrontHomePageState();
}

class _FrontHomePageState extends State<FrontHomePage> {

  String name;
  String phone;
  String email;
  User user;
  List<Category> categories = [];
  List<Shop> shops = [];

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
          this.phone = user.phone;
        });
      }
    });
    return user;
  }

  Future<List<Category>> getCategories() async{
    CollectionReference ref = Firestore.instance.collection(Category.tableName);
    QuerySnapshot snapshot = await ref.getDocuments();
    snapshot.documents.forEach((element) {
      setState(() {
        categories.add(Mapper.fromJson(element.data).toObject<Category>());
      });
    });
    return categories;
  }

  Future<List<Shop>> getShops() async{
    CollectionReference ref = Firestore.instance.collection(Shop.table_name);
    QuerySnapshot snapshot = await ref.getDocuments();
    snapshot.documents.forEach((element) {
      setState(() {
        shops.add(Mapper.fromJson(element.data).toObject<Shop>());
      });
    });
    print("===========================================${shops.toString()}");
    return shops;
  }

    @override
  void initState() {
    setUserInfo();
    getCategories();
    getShops();
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
                
                child: new RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Go',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'H',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            TextSpan(
              text: 'air',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 25),
            ),
          ]),
    ),
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
                onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>new StepperApp())),
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
      body: Column(
        children: [
          HorizontalList(categories),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (this.isLoading == true) ? SimpleLoading()
                      : SizedBox(),
                ],
              ),
            ),
          ),
          
      //     SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 20),
      //     child:FloatingSearchBar.builder(
      //   itemCount: 100,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(
      //       leading: Text(index.toString()),
      //     );
      //   },
      //   trailing: CircleAvatar(
      //     child: Text("RD"),
      //   ),
      //   drawer: Drawer(
      //     child: Container(),
      //   ),
      //   onChanged: (String value) {},
      //   onTap: () {},
      //   decoration: InputDecoration.collapsed(
      //     hintText: "Search...",
      //   ),
      // ),
      //   ),
      // ),
          Expanded(
            child: ListView.builder(
              itemCount: shops.length,
              itemBuilder: (context, i){
                Shop shop = shops[i];
                return Column(
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: ()=> Navigator.of(context).push(new MaterialPageRoute(
               // here we are passing the value of the product detail page
                builder: (context) => new Shop_Detail( 
                  shop_detail_name: Shop.label_name,
                  shop_detail_id:Shop.label_id,
                  shop_detail_image:shop.imageUrl ,
                  shop_detail_rating:shop.averageRate,
                  shop_detail_VoteCount:shop.voteCount,
                ))),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: double.infinity,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(shop.imageUrl)
                                  ),
                                  border: Border.all(color: Colors.grey)
                                ),
                              ),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10,),
                                  Text(shop.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700]
                                      )
                                  ),
                                  SizedBox(height: 4,),
                                  SmoothStarRating(
                                    starCount: 5,
                                    allowHalfRating: false,
                                    isReadOnly: true,
                                    rating: double.parse(shop.averageRate),
                                  ),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: <Widget>[
                                      Text('Avis: ', style: TextStyle(color: Colors.grey),),
                                      Text(shop.voteCount, style: TextStyle(color: Colors.grey),),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4,)
                  ],
                );
              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context)=>new StepperApp())),
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
