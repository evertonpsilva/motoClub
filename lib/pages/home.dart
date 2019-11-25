import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:motoclub/pages/motoPage.dart';
import 'package:motoclub/pages/addItem.dart';
import 'package:motoclub/controller/authentication.dart';
import 'package:speedometer/speedometer.dart';
import 'package:rxdart/rxdart.dart';


class ModelMoto{
  String name;
  String brand;
  double price;
  String thumb;

  ModelMoto({this.name, this.brand, this.price, this.thumb});
}

class Home extends StatefulWidget {

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  Home({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;

  Future<FirebaseUser> _currentUser() async{
    
    user = await _auth.currentUser();
    setState(() {
      user;
    });
    return user;
  }

  int currentPage = 0;

  PreloadPageController categoryCon;

  List<ModelMoto> motorcycles = <ModelMoto>[
    ModelMoto(name: "Africa twin sports",brand: "Honda", price: 64.990, thumb: "images/motorcycles/Africa_twin_sports_branca_bagageiro.png"),
    ModelMoto(name: "CB 650F",brand: "Honda", price: 37.915, thumb: "images/motorcycles/cb650F_cor_vermelha_2.png"),
    ModelMoto(name: "CBR 1000RR",brand: "Honda", price: 64.990, thumb: "images/motorcycles/cbr1000rr_sp_0.png"),
    ModelMoto(name: "CRF 450R",brand: "Honda", price: 64.990, thumb: "images/motorcycles/cores_CRF450R_0.png"),
    ModelMoto(name: "CB 1000R",brand: "Honda", price: 64.990, thumb: "images/motorcycles/CORES_VERMELHA_CB1000R_860x550_.png"),
    ModelMoto(name: "Gold Wing",brand: "Honda", price: 64.990, thumb: "images/motorcycles/gold_wing_tour_redblack.png"),
    ModelMoto(name: "CB 500F",brand: "Honda", price: 64.990, thumb: "images/motorcycles/Honda_Cb_500F-_Laranja_3.png"),
    ModelMoto(name: "NC 750x",brand: "Honda", price: 64.990, thumb: "images/motorcycles/nc750x-azul1.png"),
    ModelMoto(name: "Fazer 250",brand: "Yamaha", price: 64.990, thumb: "images/motorcycles/fazer-250-abs-thumb.png"),
    ModelMoto(name: "MT 03",brand: "Yamaha", price: 64.990, thumb: "images/motorcycles/mt-03-abs-thumb.png"),
    ModelMoto(name: "MT 07",brand: "Yamaha", price: 64.990, thumb: "images/motorcycles/mt-07-thumb.png"),
    ModelMoto(name: "MT 09",brand: "Yamaha", price: 64.990, thumb: "images/motorcycles/mt-09-thumb.png"),
    ModelMoto(name: "R3 ABS",brand: "Yamaha", price: 64.990, thumb: "images/motorcycles/r3-abs-thumb.png"),
    ModelMoto(name: "Super Tenere 1200 DX",brand: "Yamaha", price: 64.990, thumb: "images/motorcycles/super-tenere-1200-dx-thumb.png"),
  ];

  int countItens;
  static List<ModelMoto> motorcyclesDuplicate = <ModelMoto>[];
  int times = 0;

  _buildBrands(){

    var _brands = ["All"];

    for (var i = 0; i < motorcyclesDuplicate.length; i++) {
      if(_brands.contains(motorcyclesDuplicate[i].brand) == false){
        _brands.add(motorcyclesDuplicate[i].brand);
      }
    }

    final _brandListWidget = Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _brands.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: RaisedButton(
              color: Colors.black,
              child: Text(_brands[index], style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: "Arvo"),),
              onPressed: (){
                times++;
                setState(() {
                  _buildMotoItems(_brands[index]);
                });
              },
            ),
          );
        },
      ),
    );
    return _brandListWidget;
  }

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

    motorcyclesDuplicate.addAll(motorcycles);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(imgs[0].image, context);
    precacheImage(imgs[1].image, context);
    precacheImage(imgs[2].image, context);
  }

  _buildMotoItems(String brand){
    if(brand == "All"){
      motorcycles.clear();
      motorcycles.addAll(motorcyclesDuplicate);
    }else{
      motorcycles.clear();
      for(int i = 0; i < motorcyclesDuplicate.length; i++){
        if(motorcyclesDuplicate[i].brand == brand){
          setState(() {
            motorcycles.add(motorcyclesDuplicate[i]);
          });
        }
      }
    }
  }

  bool loadingImage = true;
  var imgs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292929),
      appBar: AppBar(
        backgroundColor: Color(0xFF292929),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        backgroundColor: Color(0xFF505050),
        elevation: 4.0,
        onPressed: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2){
                return AddItem();
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                var begin = Offset(1.0, 0.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 450),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(FontAwesomeIcons.home)
          ),
          BottomNavigationBarItem(
            title: Text("Search"),
            icon: Icon(FontAwesomeIcons.search)
          ),
          BottomNavigationBarItem(
            title: Text(""),
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            title: Text("My List"),
            icon: Icon(FontAwesomeIcons.heart)
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(FontAwesomeIcons.userCircle)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF292929),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
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
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: currentPage == index ? 300 : 260,
                            duration: Duration(milliseconds: 200),
                            child: imgs[index],
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
              Container(
                padding: EdgeInsets.fromLTRB(0, 17, 0, 17),
                width: MediaQuery.of(context).size.width,
                child: _buildBrands(),
                height: 75,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                  controller: ScrollController(initialScrollOffset: 0.6,keepScrollOffset: true,),
                  scrollDirection: Axis.horizontal,
                  itemCount: motorcycles.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MotoPage(name: motorcycles[index].name, thumb:motorcycles[index].thumb,)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        margin: index == 0 ? EdgeInsets.only(left: 10, right: 10) : EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF505050),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                              child: Text(
                                motorcycles[index].name, 
                                style: TextStyle(
                                  color: Colors.white, 
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              height: 150,
                              child: Hero(
                                tag: motorcycles[index].thumb,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(motorcycles[index].thumb),
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment.centerRight
                                    )
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}