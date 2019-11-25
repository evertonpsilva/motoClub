import 'package:flutter/material.dart';
import 'package:motoclub/controller/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motoclub/controller/loginRegister/login.dart';
import 'package:motoclub/controller/loginRegister/loginRegisterRoot.dart';
import 'package:motoclub/pages/home.dart';

enum AuthStatus{
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {

  Auth auth;
  

  RootPage({this.auth});

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.auth.getCurrentUser().then((user){
      setState(() {
        if(user != null){
          _userId = user?.uid;
        }
        authStatus = 
          user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback(){
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback(){
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.NOT_DETERMINED:
        return _waitScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return Login(
          loginAuth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if(_userId.length > 0 && _userId != null){
          return Home();
        }else{
          return _waitScreen();
        }
      break;
      default:
        return _waitScreen();
    }
  }
}

_waitScreen(){
  return Container(
    color: Colors.black,
    child: Center(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
        ),
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
      ),
    ),
  );
}