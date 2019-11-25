import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motoclub/controller/loginRegister/register.dart';
import 'package:motoclub/controller/loginRegister/loginRegisterRoot.dart';
import 'package:motoclub/controller/authentication.dart';
import 'package:motoclub/widgets/gradientButton.dart';
import 'package:motoclub/widgets/inputLogin.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Login extends StatefulWidget {

  Auth loginAuth;
  final VoidCallback loginCallback;
  
  Login({this.loginAuth, this.loginCallback});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  bool logado = false;
  static FacebookLogin fbLogin = new FacebookLogin();
  Future<FirebaseUser> _loginWithFacebook() async{
    fbLogin.logIn(['email','public_profile'])
    .then((result) async{
      switch(result.status){
        case FacebookLoginStatus.loggedIn:
          FacebookAccessToken token = result.accessToken;
          AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: token.token);
          FirebaseUser  user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
          print("Logado com:" + user.displayName);
          return user;
        break;
        default:
        break;
      }
    }).catchError((e) {
      print(e);
    });
  }
  
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _passCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;

  bool entering = false;

  bool validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async{
    setState(() {
      entering = true;
    });
    if(validateAndSave()){

      String userId = "";

      try{
        userId = await widget.loginAuth.signIn(_email, _password);
        print('Signed in: $userId');
        setState(() {
          entering = false;
        });
        if(userId.length > 0 && userId != null){
          widget.loginCallback();
        }

      }catch (e){
        setState(() {
          entering = false;
          _errorMessage = e.message;
        });
        return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Row(
                children: <Widget>[
                  Text("Erro"),
                  Icon(Icons.error, color: Colors.red,)
                ],
              ),
              content: Text(_errorMessage),
              actions: <Widget>[
                FlatButton(
                  child: Text("Entendi"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        );
        print(_errorMessage);
      }
    }
  }

  @override
  void initState(){
    super.initState();
    _errorMessage = "";
    entering = false;
  }

  void resetForm(){
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: entering ? Colors.black : Color(0xFFfbfbfb),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09,),
          height: MediaQuery.of(context).size.height,
          child: entering ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Image.asset("images/logo.png",width: 210,),
                    Text("Born to Ride, Ride to Live", style: TextStyle(color: Colors.black, fontFamily: 'Arvo',fontWeight: FontWeight.w800, fontSize: 23),),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    LoginInput(
                      validator: (value) => value.isEmpty ? 'Email não pode ser vazio' : null,
                      onSaved: (value) => _email = value.trim(),
                      type: TextInputType.emailAddress,
                      label: "Email",
                      prefixIcon: Icon(Icons.mail_outline,color: Colors.black,),
                    ),
                    LoginInput(
                      validator: (value) => value.isEmpty ? 'Senha não pode ser vazia' : null,
                      onSaved: (value) => _password = value.trim(),
                      obscureText: true,
                      label: "Senha",
                      prefixIcon: Icon(Icons.lock,color: Colors.black,),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text("Esqueceu sua senha?"),
                        onTap: (){},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: GradientButton(
                        onPressed: validateAndSubmit,
                        child: Text("ENTRAR",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.grey[800],
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                child: Text("Ou faça login usando"),
                padding: EdgeInsets.only(top: 30, bottom: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 130,
                    child: RaisedButton(
                      elevation: 1,
                      child: Row( 
                        children:[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              FontAwesomeIcons.facebookF, 
                              size: 16, 
                              color: Colors.white,
                            ),
                          ),
                          Text("Facebook",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                        ],
                      ),
                      onPressed:()async{
                        await _loginWithFacebook().then((user){
                          
                          Navigator.of(context).pushReplacementNamed("/home",);
                        });
                      },
                      color: Color(0xFF385c8e),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    child: RaisedButton(
                      elevation: 1,
                      child: Row( 
                        children:[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              FontAwesomeIcons.google, 
                              size: 16, 
                              color: Colors.white,
                            ),
                          ),
                          Text("Google",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),)
                        ],
                      ),
                      onPressed: (){},
                      color: Color(0xFFf14436),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Não possui uma conta? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                      },
                      child: Text("Registrar-se agora!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}