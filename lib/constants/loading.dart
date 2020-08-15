import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_hair/constants/global_datas.dart';


class LoadingPage extends StatefulWidget {
  LoadingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitCircle(
              color: setColor(color: 'primary'),
            )
          ],
        ),
      )
    );
  }
}


class LoadingPageStateless extends StatelessWidget {
  const LoadingPageStateless({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitCircle(
            color: setColor(color: 'primary'),
          )
        ],
      ),
    );
  }
}

SimpleLoading(){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitCircle(
          color: setColor(color: 'primary'),
        )
      ],
    ),
  );
}