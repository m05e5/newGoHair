import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/models/category.dart';
import 'package:go_hair/models/hair_style.dart';
import 'package:object_mapper/object_mapper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Shop_Detail extends StatefulWidget {
  final shop_detail_name;
  final shop_detail_id;
  final shop_detail_image;
  final shop_detail_rating;
  final shop_detail_VoteCount;

  Shop_Detail({
    this.shop_detail_name,
    this.shop_detail_id,
    this.shop_detail_image,
    this.shop_detail_rating,
    this.shop_detail_VoteCount,
  });

  @override
  _Shop_DetailState createState() => _Shop_DetailState();
}

class _Shop_DetailState extends State<Shop_Detail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Category> categories = [];
  List<HairStyle> hairStyles = [];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    getHairStyles();
    super.initState();
  }

  getHairStyles() async{
    CollectionReference ref = Firestore.instance.collection(HairStyle.tableName);
    QuerySnapshot snapshot = await ref.getDocuments();
    snapshot.documents.forEach((element) {
      setState(() {
        hairStyles.add(Mapper.fromJson(element.data).toObject<HairStyle>());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Stack(alignment: Alignment.bottomLeft, children: <Widget>[
            Image.network(
              widget.shop_detail_image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(children: <Widget>[
              Text(
                "Hello",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              ),
              SizedBox(
                height: 10,
              ),
              SmoothStarRating(
                starCount: 5,
                allowHalfRating: false,
                isReadOnly: true,
                rating: double.parse(widget.shop_detail_rating),
              ),
            ])
          ]),
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelColor: Colors.orange,
            isScrollable: true,
            labelPadding: EdgeInsets.only(right: 35.0),
            unselectedLabelColor: Color(0xFFCDCDCF),
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Coiffure homme",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Varela'),
                ),
              ),
              Tab(
                child: Text(
                  "Coiffure femme",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Varela'),
                ),
              ),
              Tab(
                child: Text(
                  "Coiffure homme",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Varela'),
                ),
              ),
              Tab(
                child: Text(
                  "Coiffure homme",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'Varela'),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.orange,
            height: 5,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
          Expanded(
            child: TabBarView(
              children: [
                coiffureFemme(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }

  Widget coiffureFemme() {
    print(hairStyles.length);
    return ListView.builder(
        itemCount: hairStyles.length,
        itemBuilder: (context, i) {
          print(hairStyles.length);
          print("--------------------------------------------------");
          HairStyle hairStyle = hairStyles[i];

          return Column(
            children: <Widget>[
              Card(
                elevation: 4,
                child: FlatButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: double.infinity,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(hairStyle.photoUrl)),
                                border: Border.all(color: Colors.grey)),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(hairStyle.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700])),
                            ],
                          )
                        ],
                      ),
                    )),
              )
            ],
          );
        });
  }
}
