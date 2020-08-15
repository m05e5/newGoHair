import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_hair/constants/global_datas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_hair/constants/loading.dart';
import 'package:go_hair/pages/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xfffbb448)])),
        child: ListView(
          children: [
            Container(
              child: Center(
                  child: new Column(
                    children: <Widget>[
                      SizedBox(height: 12.0),
                      Text("Inscription", textScaleFactor: 2),
                    ],
                  )
              ),

            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: RegisterForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {


  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _name;
  int _phone;
  String _email;
  String _password;
  String _confirmPassword;

  bool _passwordVisible = false;
  bool _iHaveSalon = false;
  bool _acceptedTermsAndConditions = false;
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  final CollectionReference userCollection = Firestore.instance.collection('users');

  String _getUserId(){
    if(this._currentUser != null){
      return this._currentUser.uid;
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

  void _toggleIHaveSalon(bool value) {
    setState(() {
      _iHaveSalon = !_iHaveSalon;
    });
  }

  void _toggleTermsAndConditions(bool value) {
    setState(() {
      _acceptedTermsAndConditions = !_acceptedTermsAndConditions;
    });
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0;

    // Reccupere l'utilisateur connecté
    FirebaseAuth.instance.currentUser().then((FirebaseUser user){
      setState((){
        this._currentUser = user;
      });
    });

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
                  Checkbox(
                    value: _iHaveSalon,
                    onChanged: _toggleIHaveSalon,
                  ),
                  Text("Je possède un salon de coiffure"),
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
            child: RaisedButton(
              color: setColor(color: 'primary'),
              child: Text("S'inscrire", style: TextStyle(color: Colors.white)),
              onPressed: () => _register(context),
            ),
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
  }

  void _register(BuildContext context) async {
    if (_formKey.currentState.validate()) {

      setState((){
        this.isLoading = true;
      });

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);

      await userCollection.document(this._getUserId()).setData({
        'id': this._getUserId(),
        'name': this._name,
        'email': this._email,
        'phone': this._phone,
      });

      if (result == null) {
        // Message d'erreur
        print('Une erreur est survenue');
      }
      print('Successs');
    }
  }




  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
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

  Widget _submitButton() {
    return Container(
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
        'Register Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryField("Email id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }
}
