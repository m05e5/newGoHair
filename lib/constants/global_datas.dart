import 'package:flutter/material.dart';


Color setColor({String color='black'}) {
  if (color == 'primary') {
    return Colors.blue;
  } else if (color == 'secondary') {
    return Colors.grey[700];
  } else if (color == 'default') {
    return Colors.grey;
  } else if (color == 'success') {
    return Colors.green;
  } else if (color == 'warning') {
    return Colors.yellow;
  } else if (color == 'danger') {
    return Colors.red;
  } else{
    return Colors.black;
  }
}

Padding padding() {
  return new Padding(padding: EdgeInsets.only(top: 20.0));
}