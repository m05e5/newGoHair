import 'package:flutter/material.dart';


class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var products_on_the_cart = [
    {
       "name": "Fashon police",
      "picture":  "assets/catalogue/card1.jpg",
       "price": 70,

    },
    {
      "name": "Obama fashon",
      "picture":  "assets/catalogue/card2.jpg",
      "price": 100,

    },
    {
       "name": "slim fashon",
      "picture":  "assets/catalogue/card5.jpg",
      "price": 130,

    },
    {
       "name": "Fashon police",
      "picture":  "assets/catalogue/card1.jpg",
       "price": 70,

    },
    {
       "name": "Fashon police",
      "picture":  "assets/catalogue/card1.jpg",
       "price": 70,

    },
    
    {
       "name": "Fashon police",
      "picture":  "assets/catalogue/card1.jpg",
       "price": 70,

    },
    {
       "name": "Fashon police",
      "picture":  "assets/catalogue/card1.jpg",
       "price": 70,

    },
    {
       "name": "Fashon police",
      "picture":  "assets/catalogue/card1.jpg",
       "price": 70,

    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return  new ListView.builder(
      itemCount: products_on_the_cart.length,
      itemBuilder: (context, index){
      return  new Single_cart_product(
        cart_prod_name:products_on_the_cart[index]["name"],
        cart_prod_price:products_on_the_cart[index]["price"], 
        cart_prod_picture:products_on_the_cart[index]["picture"],


        
      );
      } );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;


  Single_cart_product({
  this.cart_prod_name,
  this.cart_prod_picture,
  this.cart_prod_price,

  }); 
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
         padding: EdgeInsets.symmetric(vertical: 7.0),
        child: ListTile(
//            ================= LEADING SECTION ==================== 
          leading: ClipRRect(
            
              borderRadius: BorderRadius.circular(15),
                    child: new Image.asset(
              
              cart_prod_picture,
               width: 70.0,
               height: 60.0,
               fit: BoxFit.fill
               ),
          ),


//         ================= TITLE SECTION =====================          
          title: new Text(cart_prod_name, style: TextStyle(fontWeight: FontWeight.bold,),),

//         ================ SUBTITLE SECTION =================
          subtitle: new Column(
            children: <Widget>[
//           ROW INSIDE COLOMN  
            
//     ============this section is for the size of the product ================
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new Text("Size:"),
                    ),
                      Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text("cart_prod_size",style: TextStyle(color: Colors.red),),
                ),
                  ],
                ),
              



//       ============THIS SECTION IS FOR THE PRODUCT PRICE==============
             new Container(
               alignment: Alignment.topLeft,
               child: new Text(
                 "A paetie de ${cart_prod_price}frs",
                  style: TextStyle(
                    fontSize: 16.0,
                    
                    color: Colors.orange
                    ), )
             ),


            ],
          ),
          
        ),
      ),
    );
  }
}