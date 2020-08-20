import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/constants/custom_widgets.dart';
import 'package:go_hair/constants/loading.dart';
import 'package:go_hair/models/role.dart';
import 'package:go_hair/models/shop.dart';
import 'package:go_hair/models/user.dart';
import 'package:go_hair/pages/auth/isAuthenticated_C.dart';
import 'package:go_hair/pages/front/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
class SignInCoiffeur extends StatefulWidget {
   SignInCoiffeur({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignInCoiffeurState createState() => _SignInCoiffeurState();
}

class _SignInCoiffeurState extends State<SignInCoiffeur> {
  @override
  
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(

        title: Text('Inscription coiffeur'),
         backgroundColor: Color(0xfff7892b),
      ),
      body:Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: (orientation == Orientation.portrait) ? BezierContainer() : NotBezierContainer()
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    RegisterCoiffeur(),

                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),

    );
  }


   Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }


Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Go',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'H',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'air',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );

    
  }
  
   Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryField("Salonname"),
        _entryField("Phone"),
        _entryField("SalonPhone"),
        _entryField("Email id"),
        _entryField("SalonEmail id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }


}


class  RegisterCoiffeur extends StatefulWidget {
  @override
  _RegisterCoiffeurState createState() => _RegisterCoiffeurState();
}

class _RegisterCoiffeurState extends State<RegisterCoiffeur> {

   final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _salonNameController = TextEditingController();
  final _phoneController = TextEditingController();
   final _salonphoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _salonemailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _name;
  String _salonName;
  int _phone;
  int _salonphone;
  String _email;
  String _salonemail;
  String _password;
  String _confirmPassword;

  bool _passwordVisible = false;
  bool _acceptedTermsAndConditions = false;
  bool isLoading = false;

    FirebaseAuth _auth_C = FirebaseAuth.instance;
  FirebaseUser _currentCoiffeur;

   final CollectionReference shopCollection = Firestore.instance.collection('shop');
   final CollectionReference userCollection = Firestore.instance.collection('user');


  @override
  Widget build(BuildContext context) {
    const spacing = 12.0;

    
    // Reccupere l'utilisateur connecté
    FirebaseAuth.instance.currentUser().then((FirebaseUser coiffeur){
      setState((){
        this._currentCoiffeur = coiffeur;
      });
    });
    
      if (this.isLoading == false) {
      return Form(
        key: _formKey,
        autovalidate: false,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              validator: _validateName,
              decoration: InputDecoration(
                labelText: "Nom et Prénom",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: _phoneController,
              validator: _validatePhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Téléphone",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _phone = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: _emailController,
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(height: spacing),
             TextFormField(
              controller: _salonNameController,
              validator: _validateName,
              decoration: InputDecoration(
                labelText: "Nom du salon",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _salonName = value;
                });
              },
            ),
            SizedBox(height: spacing),
             TextFormField(
              controller: _salonphoneController,
              validator: _validatePhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Téléphone du salon",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _salonphone = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: _salonemailController,
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email de votre salon",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _salonemail = value;
                });
              },
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: _passwordController,
              validator: _validatePassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                labelText: "Mot de passe",
                border: OutlineInputBorder(),
              ),
              obscureText: !_passwordVisible,
              onChanged: (String value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: spacing),
            TextFormField(
              controller: _confirmPasswordController,
             validator: _validateConfirmPassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                labelText: "Confirmez votre mot de passe",
                border: OutlineInputBorder(),
              ),
              obscureText: !_passwordVisible,
              onChanged: (String value) {
                setState(() {
                  _confirmPassword = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Possedez vous un salon ?"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                 
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _acceptedTermsAndConditions,
                onChanged: _toggleTermsAndConditions,
                ),
                Flexible(
                  child: Text("J'accepte les termes et conditions d'utilisation de l'application"),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
             child: _submitButton(),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: FlatButton(
                splashColor: Theme.of(context).accentColor,
                child: Text("Je possède déja un compte"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          ],
        ),
      );
    }else{
      return SimpleLoading();
    }
  }
  

  String _getUserId(){
    if(this._currentCoiffeur != null){
      return this._currentCoiffeur.uid;
    }else{
      return '';
    }
  }
  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
  String _validateName(String value) {
    if (value.isEmpty) {
      return "Entrez votre nom svp";
    }
    return null;
  }
   String _validatePhone(String value) {
    var potentialNumber = int.tryParse(value);
    if (potentialNumber == null) {
      return 'Entrez votre numero de téléphone svp';
    }
    return null;
  }
   String _validateEmail(String value) {
    if (value.isEmpty || !EmailValidator.validate(value)) {
      return "Entrez un email valide svp";
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return "Entrez un mot de passe valide svp";
    }else if (value.length < 7) {
      return "Votre mot de passe doit être supérieur à 6 charactères";
    }else if (this._password != this._confirmPassword) {
      return "Votre mot de passe ne correspond pas";
    }
    return null;
  }
  
  String _validateConfirmPassword(String value) {
    if (this._password != this._confirmPassword) {
      return "Entrez le même mot de passe svp";
    }
    return null;
  }
  void _toggleTermsAndConditions(bool value) {
    setState(() {
      _acceptedTermsAndConditions = !_acceptedTermsAndConditions;
    });
  }
  Widget _submitButton() {
    return InkWell(
        onTap: () => _register(context),
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
            "S'inscrire",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )

    );
  }


  void _register(BuildContext context) async {
    if (_formKey.currentState.validate()) {

      setState((){
        this.isLoading = true;
      });

      AuthResult result = await _auth_C.createUserWithEmailAndPassword(email: _email, password: _password);
      var uuid = Uuid();
      String shopId = uuid.v1();
      if(result != null){
        await userCollection.document(this._getUserId()).setData({
          User.label_id: result.user.uid,
          User.label_name: this._name,
          User.label_email: this._email,
          User.label_phone: this._phone,
          User.label_role: Role.roleBarber,
          User.label_shop_id: shopId
        });

        

        await shopCollection.document().setData({
          Shop.label_id: shopId,
          Shop.label_user_id: result.user.uid,
          Shop.label_name: this._salonName,
          Shop.label_phone: this._salonphone,
          Shop.label_email: this._salonemail
        });
      }



      if (result == null) {
        // Message d'erreur
        print('Une erreur est survenue');
      }

      print('Successs');
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return FrontHomePage();
        })).then((value) => Navigator.pop(context));
      setState((){
        this.isLoading = false;
      });

    }
  }




  
  
}