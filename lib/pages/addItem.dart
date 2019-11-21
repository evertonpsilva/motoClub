import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  File _image;

  Future _setImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  _clearImage(){
    setState(() {
      _image = null;
    });
  }

  bool inserting = false;

  void _addMoto({String name, String, brand, String price, String category, String highSpeed, String color, File imgFile}) async{
    setState(() {
      inserting = true;
    });
    if(imgFile == null) return;
    StorageUploadTask task = FirebaseStorage.instance.ref().
      child('MOTORCYCLEITEM' +
      DateTime.now().millisecondsSinceEpoch.toString()).putFile(imgFile);
    StorageTaskSnapshot snap = await task.onComplete;
    var imgUrl = await snap.ref.getDownloadURL();
    Firestore.instance.collection("motorcycles").add(
      {
        "name" : name,
        "brand" : brand,
        "price" : price,
        "category" : category,
        "highSpeed" : highSpeed,
        "imgUrl" : imgUrl,
      }
    ).catchError((erro){
      print("Erro" + erro);
      setState(() {
        inserting = false;
      });
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Ops!"),
            content: Text("Houve um erro. Tente novamente"),
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
    }).whenComplete((){
      print("deu bom");
      setState(() {
        inserting = false;
        _nameCon.clear();
        _brandCon.clear();
        _priceCon.clear();
        _categoryCon.clear();
        _speedCon.clear();
        currentColor = pickerColor;
        _image = null;
      });
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Tudo certo!"),
            content: Text("Moto Adicionada com sucesso!"),
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
    });
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  Future setColor(){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              enableLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => currentColor = pickerColor);
                print(currentColor.toString());
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      } 
    );
  }

  Color pickerColor = Color(0xffff0000);
  Color currentColor = Color(0xffffffff);

  TextEditingController _nameCon = TextEditingController();
  TextEditingController _brandCon = TextEditingController();
  TextEditingController _priceCon = TextEditingController();
  TextEditingController _categoryCon = TextEditingController();
  TextEditingController _speedCon = TextEditingController();

  String prefixText = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  _getCurrentUser() async{
    user = await auth.currentUser();
    print(user);
  }

  @override
  void initState(){
    super.initState();

    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF292929),
        title: Text("Add Motorcycle Item", style: TextStyle(fontFamily: "Arvo", fontWeight: FontWeight.w500),),
      ),
      backgroundColor: Color(0xFF292929),
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Container(
            height: MediaQuery.of(context).size.height - 86,
            child: inserting ? Center(
              child: CircularProgressIndicator(),
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _image == null ? 
                Container(
                  margin: EdgeInsets.only(top: 35, bottom: 35),
                  width: double.infinity,
                  child: GestureDetector(
                    child: Text("Add Photo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 42,fontFamily: "Arvo"),textAlign: TextAlign.center,),
                    onTap: _setImage, 
                  ),
                ) :
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 35),
                    child: Image.file(_image, width: 240, height: 160,fit: BoxFit.contain,),
                  ),
                  onTap: (){
                    return showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc){
                        return Container(
                          color: Color(0xFF292929),
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(FontAwesomeIcons.edit, color: Colors.white,),
                                title: Text("Change photo", style: TextStyle(color: Colors.white),),
                                onTap: (){
                                  _setImage();
                                  Navigator.pop(context);
                                },
                              ),
                              Divider(
                                color: Color(0xFF292929),
                              ),
                              ListTile(
                                leading: Icon(FontAwesomeIcons.times, color: Colors.white,),
                                title: Text("Remove photo", style: TextStyle(color: Colors.white),),
                                onTap: (){
                                  _clearImage();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  },
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: TextField(
                          controller: _nameCon,
                          onChanged: (String text){
                            setState(() {
                              _nameCon;
                            });
                          },
                          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _nameCon.text == "" ? Color(0xFF292929) : Colors.white,
                                width: 2.0
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            labelText: "Moto name",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: TextField(
                          controller: _brandCon,
                          onChanged: (String text){
                            setState(() {
                              _brandCon;
                            });
                          },
                          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _brandCon.text == "" ? Color(0xFF292929) : Colors.white,
                                width: 2.0
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            labelText: "Brand",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          controller: _priceCon,
                          onChanged: (String text){
                            setState(() {
                              _priceCon;
                              if(text == ""){
                                prefixText = "";
                              }else{
                                prefixText = "R\$ ";
                              }
                            });
                          },
                          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            prefixText: prefixText,
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _priceCon.text == "" ? Color(0xFF292929) : Colors.white,
                                width: 2.0
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            labelText: "Price",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                      
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                        child: TextField(
                          controller: _categoryCon,
                          onChanged: (String text){
                            setState(() {
                              _categoryCon;
                            });
                          },
                          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _categoryCon.text == "" ? Color(0xFF292929) : Colors.white,
                                width: 2.0
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            labelText: "Category",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(25, 10, 25, 20),
                        child: TextField(
                          controller: _speedCon,
                          onChanged: (String text){
                            setState(() {
                              _speedCon;
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _speedCon.text == "" ? Color(0xFF292929) : Colors.white,
                                width: 2.0
                              )
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            labelText: "High Speed",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 24, fontFamily: "Arvo", fontWeight: FontWeight.w600)
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                child: RaisedButton(
                                  child: Text(""),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(60.0),
                                    side: BorderSide(color: Colors.white)
                                  ),
                                  color: pickerColor,
                                  onPressed: setColor,
                                ),
                              ),
                              Text("Moto Color", style: TextStyle(color: Colors.white, fontSize: 8),)
                            ],
                          ),
                          Container(
                            height: 45,
                            child: RaisedButton(
                              color: Colors.white,
                              child: Text("Add Motorcycle",style: TextStyle(fontFamily: "Arvo",color: Color(0xFF292929), fontSize: 20, fontWeight: FontWeight.w600),),
                              onPressed: (){
                                _addMoto(name: _nameCon.text,brand: _brandCon.text, price: _priceCon.text, category: _categoryCon.text,highSpeed: _speedCon.text,color: currentColor.toString(),imgFile: _image);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
              ],
            )
          ),
        ),
      ),
    );
  }
}