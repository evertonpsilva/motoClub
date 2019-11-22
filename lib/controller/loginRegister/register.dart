import 'package:flutter/material.dart';
import 'package:motoclub/widgets/gradientButton.dart';
import 'package:motoclub/controller/loginRegister/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motoclub/widgets/inputLogin.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool registering = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;

  Future<String> signUp(String name, String email, String password) async{
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email, password: password).catchError((erro){
        setState(() {
          registering = false;
        });
        return showDialog(
          context: context,
          builder: (BuildContext context){
            print("Erro" + erro);
            return AlertDialog(
              title: Text("Erro!"),
              content: Text("Ocorreu um erro"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Fechar"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        );
    }).then((AuthResult res){
      setState(() {
        registering = false;
      });
      
      user = res.user;
      return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text("Tudo certo!!!"),
                Icon(Icons.check_circle, color: Colors.green,)
              ],
            ),
            content:Text("Usuário criado com sucesso!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Fechar"),
                onPressed: (){
                  _nameCon.clear();
                  _emailCon.clear();
                  _passwordCon.clear();
                  _confirmPasswordCon.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      );
    });

    user.sendEmailVerification();
    
    _auth.currentUser().then((val){
      UserUpdateInfo addName = UserUpdateInfo();
      addName.displayName = name;
      val.updateProfile(addName).whenComplete((){print("Foi");});
    });

    return user.uid;
  }

  TextEditingController _nameCon = TextEditingController();
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _passwordCon = TextEditingController();
  TextEditingController _confirmPasswordCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("aa"),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFfbfbfb),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 85,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09,),
          child: registering ? 
            Center(
              child: Container(
                padding: EdgeInsets.all(10),
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text("Vamos começar!", style: TextStyle(color: Colors.black, fontFamily: 'Arvo',fontWeight: FontWeight.w800, fontSize: 23),),
                    Text("Preencha os dados para criar sua conta", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14),),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    LoginInput(label: "Nome",obscureText: false,controller: _nameCon,prefixIcon: Icon(Icons.person_outline, color: Colors.black,),type: TextInputType.text,),
                    LoginInput(label: "E-Mail",obscureText: false,controller: _emailCon,prefixIcon: Icon(Icons.mail_outline, color: Colors.black),type: TextInputType.emailAddress,
                        validator: validateEmail,),
                    LoginInput(label: "Senha",obscureText: true,controller: _passwordCon,prefixIcon: Icon(Icons.lock, color: Colors.black),),
                    LoginInput(
                      label: "Confirmar senha", 
                      obscureText: true, 
                      controller: _confirmPasswordCon,
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Campo não pode estar vazio';
                        }else if(value != _passwordCon.text){
                          return 'Senhas não conferem';
                        }else{
                          return null;
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: GradientButton(
                        onPressed: (){
                          if(_nameCon.text == "" || _emailCon.text == "" || _passwordCon.text == "" || _confirmPasswordCon.text == ""){
                            return showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("Erro"),
                                  content: Text("Preencha todos os campos"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Fechar"),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              }
                            );
                          }else{
                            if(_formKey.currentState.validate()){
                              setState(() {
                                registering = true;
                              });
                              signUp(_nameCon.text, _emailCon.text, _passwordCon.text);
                            }
                          }
                          
                        },
                        child: Text("CRIAR",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
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
                padding: EdgeInsets.only(top: 30, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Já possui uma conta? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text("Faça o login!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),),
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