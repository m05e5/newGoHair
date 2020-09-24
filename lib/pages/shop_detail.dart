import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class Shop_Detail extends StatefulWidget {
   final shop_detail_name;
  final  shop_detail_id;
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

class _Shop_DetailState extends State<Shop_Detail> with SingleTickerProviderStateMixin{
  TabController _tabController;

@override
void initState(){
  super.initState();
  _tabController = TabController(length: 4, vsync: this);
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: <Widget>[
        
        Stack(
    alignment: Alignment.bottomLeft,
    children: <Widget>[
        Image.network(
             widget.shop_detail_image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                children: <Widget>[
                      Text("Hello", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 22.0)  ,),
         SizedBox(height: 10,),
                SmoothStarRating(
                  
                  starCount: 5,
                 allowHalfRating: false,
                  isReadOnly: true,
                  rating: double.parse(widget.shop_detail_rating),
                  ),
                ]
              )
      
    ]
),
    TabBar(
      controller: _tabController,
      indicatorColor: Colors.transparent,
      labelColor:   Colors.orange,
      isScrollable: true,
      labelPadding: EdgeInsets.only(right: 35.0 ),
      unselectedLabelColor: Color(0xFFCDCDCD),
      
      tabs: <Widget>[
        Tab(
          child:Text("Coiffure homme",
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Varela'
          ),  ),
        ),
        Tab(
          child:Text("Coiffure homme",
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Varela'
          ),  ),
        ),
        Tab(
          child:Text("Coiffure homme",
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Varela'
          ),  ),
        ),Tab(
          child:Text("Coiffure homme",
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Varela'
          ),  ),
        ),
      ],
    ),
    TabBarView(
     
              children: [
  
                Text("hello"),
  
                Icon(Icons.directions_transit),

                Icon(Icons.directions_transit),
  
                Icon(Icons.directions_bike),
  
              ],
  
            ),
    

      ],),
      
    );
  }
}













// Expanded(
//   child:   DefaultTabController(length: 4,
  
//           child: Scaffold(
  
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
  
//               bottom: TabBar(
  
//                 tabs: [
  
//                   Tab(text: "hello"),

//                   Tab(text: "hello"),
  
//                   Tab(icon: Icon(Icons.directions_transit)),
  
//                   Tab(icon: Icon(Icons.directions_bike)),
  
//                 ],
  
//               ),
  

//             ),
  
//             body: TabBarView(
  
//               children: [
  
//                 Text("hello"),
  
//                 Icon(Icons.directions_transit),

//                 Icon(Icons.directions_transit),
  
//                 Icon(Icons.directions_bike),
  
//               ],
  
//             ),
  
//           ),),
// ),