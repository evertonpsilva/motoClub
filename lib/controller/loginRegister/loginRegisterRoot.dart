import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _next(){
    Future.delayed(Duration(milliseconds: 2780),(){
      Navigator.pushNamed(context, "/home");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _next();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFfbfbfb),
      child: FlareActor("flares/sucess_flare.flr", animation: "sucess", alignment:Alignment.center, fit:BoxFit.contain,),
    );
  }
}