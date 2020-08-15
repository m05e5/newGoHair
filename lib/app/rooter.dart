import 'package:flutter/material.dart';

import 'package:go_hair/pages/auth/register.dart';
import 'package:go_hair/pages/auth/login.dart';

navigateToLogin(BuildContext context){
  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
    return new LoginPage();
  }));
}

navigateToRegister(BuildContext context){
  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
    return new RegisterPage();
  }));
}