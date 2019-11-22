import 'package:flutter/material.dart';
import 'package:speedometer/speedometer.dart';

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
      backgroundColor: Color(0xFF292929),
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: Color(0xFF505050),
                  flexibleSpace: FlexibleSpaceBar(
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
            body: Container(),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xFF353535),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(widget.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 32, fontFamily: "Arvo"),overflow: TextOverflow.ellipsis,maxLines: 2,),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Icon(Icons.send, color: Color(0xFF353535),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}