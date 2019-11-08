import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  FirebaseUser user;
  int currentPage = 0;

  PreloadPageController categoryCon;


  var colors = <Color>[
    Colors.black,
    Colors.red,
    Colors.blue,
  ];

  var categories = [
    "Sport",
    "Bonneville",
    "Custom"
  ];

  bool loadingImage = true;
  var imgs;

  @override
  void initState(){
    super.initState();
    imgs = [
      Image.asset("images/home/sports.jpg"),
      Image.asset("images/home/harley.jpg"),
      Image.asset("images/home/trail.jpg"),
    ];
    categoryCon = PreloadPageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1
    );

    Future.delayed(Duration(milliseconds: 800), (){
      setState(() {
        loadingImage = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imgs[0].image, context);
    precacheImage(imgs[1].image, context);
    precacheImage(imgs[2].image, context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Moto Club", style: TextStyle(fontFamily: "Arvo", fontWeight: FontWeight.w700),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              return Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: PreloadPageView.builder(
                    preloadPagesCount: 3,
                    physics: AlwaysScrollableScrollPhysics(),
                    onPageChanged: (int index){
                      setState(() {
                        currentPage = index;
                      });
                    },
                    controller: categoryCon,
                    itemCount: 3,
                    itemBuilder: (context, index){
                      return loadingImage ? Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Colors.white,
                            ),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        ) : SizedBox(
                        height: 300,
                        child: Stack(
                          children: <Widget>[
                            AnimatedContainer(
                              alignment: Alignment.center,
                              height: currentPage == index ? 300 : 260,
                              duration: Duration(milliseconds: 200),
                              child: imgs[index],
                              margin: currentPage == index ? EdgeInsets.only(top: 0) : EdgeInsets.only(top: 40),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: DotsIndicator(
                      dotsCount: imgs.length,
                      position: currentPage.toDouble(),
                      decorator: DotsDecorator(
                        color: Colors.grey[700],
                        activeColor: Colors.red,
                        size: const Size.square(9.0),
                        activeSize: const Size(14.0, 14.0),
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  )
                ),
              ],
            ),
            RaisedButton(
              child: Text("pr"),
              onPressed: (){
                print(user.displayName);
              },
            ),
          ],
        ),
      ),
    );
  }
}