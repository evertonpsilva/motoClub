import 'package:flutter/material.dart';

class MotoPage extends StatefulWidget {
  String name;
  String thumb;
  MotoPage({this.name,this.thumb});

  @override
  _MotoPageState createState() => _MotoPageState();
}

class _MotoPageState extends State<MotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Color(0xFF505050),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )
                ),
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  child:Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned(
                        left: -200,
                        top: -65,
                        bottom: -65,
                        child: Hero(
                          tag: widget.thumb,
                          child:Image(
                            image: AssetImage(widget.thumb),
                            height: 200,
                            fit:BoxFit.contain,
                            alignment: Alignment.centerRight,
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
          decoration: BoxDecoration(
            color: Color(0xFF292929),
          ),
          child:SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("A PARTIR DE\nR\$ 35.000,00", style: TextStyle(color: Colors.white, fontFamily: "Arvo", fontWeight: FontWeight.w600, fontSize: 23),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}