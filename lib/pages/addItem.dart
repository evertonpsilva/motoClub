import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF292929),
        title: Text("Add Motorcycle Item", style: TextStyle(fontFamily: "Arvo", fontWeight: FontWeight.w500),),
      ),
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Container(
            height: MediaQuery.of(context).size.height - 86,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment:Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 150,
                        color: Colors.red,
                      ),
                    ),
                    _image == null ? 
                    Container(
                      margin: EdgeInsets.only(top: 55),
                      width: 220,
                      child: GestureDetector(
                        child: Icon(Icons.add_a_photo,size: 95,),
                        onTap: _setImage, 
                      ),
                    ) :
                    GestureDetector(
                      child: Image.file(_image, width: 240, height: 160,fit: BoxFit.contain,),
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
                  ],
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            hintText: "Moto name"
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            hintText: "Brand"
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            hintText: "Price"
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            hintText: "Category"
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF292929),
                              )
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                color:Color(0xFF292929),
                              )
                            ),
                            hintText: "Color"
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 55),
                  child: RaisedButton(
                    child: Text("Adicionar moto"),
                    onPressed: (){},
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