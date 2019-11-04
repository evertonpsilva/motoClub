import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentPage = 0;

  PageController categoryCon;

  var colors = <Color>[
    Colors.black,
    Colors.red,
    Colors.blue,
  ];

  var imgs = [
    "https://newspalteodesk.tk/photo/419935.jpg",
    "https://www.iamabiker.com/wp-content/uploads/2018/12/Triumph-Speed-Twin-1200-phone-wallpaper.jpg",
    "https://picserio.com/data/out/428/motorcycle-phone-wallpaper_6313493.jpg",
  ];

  var categories = [
    "Sport",
    "Bonneville",
    "Custom"
  ];

  @override
  void initState(){
    super.initState();
    categoryCon = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 0.85,
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Moto Club", style: TextStyle(fontFamily: "Arvo", fontWeight: FontWeight.w700),),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 320,
              child: PageView.builder(
                onPageChanged: (int index){
                  setState(() {
                    currentPage = index;
                  });
                },
                controller: categoryCon,
                itemCount: 3,
                itemBuilder: (context, index){
                  return SizedBox(
                    height: 300,
                    child: Stack(
                      children: <Widget>[
                        AnimatedContainer(
                          alignment: Alignment.center,
                          height: currentPage == index ? 300 : 260,
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(imgs[index]),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: currentPage == index ? EdgeInsets.only(top: 0, left: 10, right: 10) : EdgeInsets.only(top: 20, left: 10, right: 10),
                        ),
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          bottom: currentPage == index ? -5 : 15,
                          left: 0,
                          right: 0,
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: RaisedButton(
                              color: Colors.black,
                              elevation: 1,
                              onPressed: (){},
                              child: Text(categories[index],style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600, fontFamily: "Arvo"),),
                            ),
                          )
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}