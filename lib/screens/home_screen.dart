import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/service1catogery.dart';
import 'package:Homeplex/labourservice/serviceCatogary2.dart';
import 'package:Homeplex/layout/navbar.dart';
import 'package:Homeplex/layout/uploadrentwidgets.dart';
import 'package:Homeplex/login/model/user_model.dart';
import 'package:Homeplex/screens/results_screen.dart';
import 'package:Homeplex/transportation/first_screen_transport.dart';
import '../labourservice/servicecatogary3.dart';
import '../layout/catagory_screen.dart';
import '../resources/cloudfirestore_methods.dart';
import '../transportation/phone.dart';
import '../watertanker/transportui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkLoaded = true;
  var _dotPosition = 0;
  ScrollController controller = ScrollController();
  double offset = 0;
  // String ?linkRef ;
  DocumentReference? linkRef;
  List<Widget>? discount70;
  final List<String> carouselImages = [
    'assets/banner2.png',
    'assets/homeinspection1.png',
    'assets/banner3.png',
    'assets/banner4.png',
    'assets/Consultancy.png',
    'assets/banner1.png',
    'assets/transport.png',
  ];
  //Consultancy
  // fetchCarouselImages() async {
  //   QuerySnapshot qn = await _firestoreInstance.collection("imageslider").get();
  //   setState(() {
  //     for (int i = 0; i < qn.docs.length; i++) {
  //       carouselImages.add(
  //         qn.docs[i]["imagepath"],
  //       );
  //     }
  //   });
  //   return qn.docs;
  // }

  @override
  void initState() {
    super.initState();
    getData();
    //  fetchCarouselImages();
    getuserdata();
    // checkRole();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String role = 'user';

  void getuserdata() async {
    //super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 = await CloudFirestoreClass()
        .getProductsFromDiscount("Kathmandu", "house", "yes");
    setState(() {
      discount70 = temp70;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0.5,
            backgroundColor: Colors.teal,
            title: Text(
              " Welcome ${loggedInUser.name} ",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          drawer: const NavBar(),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.teal,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.search,
                              color: Color(0xff0E4d92),
                            ),
                            title: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (String query) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ResultsScreen(query: query),
                                    ));
                              },
                              decoration: const InputDecoration(
                                hintText: "Search Room by the location",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 2.4,
                      child: CarouselSlider(
                          items: carouselImages
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 3),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(item),
                                              fit: BoxFit.fitWidth)),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 1.0,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (val, carouselPageChangedReason) {
                                setState(() {
                                  _dotPosition = val;
                                });
                              })),
                    ),
                    DotsIndicator(
                        dotsCount:
                            carouselImages.isEmpty ? 1 : carouselImages.length,
                        position: _dotPosition.toDouble(),
                        decorator: const DotsDecorator(
                          activeColor: Colors.orange,
                          color: Colors.grey,
                          spacing: EdgeInsets.all(2),
                          activeSize: Size(8, 8),
                          size: Size(6, 6),
                        )),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 1, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Upload Your Properties for Rent',
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const UploadProperties(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 1, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Find Rent',
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const RentServices(),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 0.0),
                          child: Text(
                            "House/office shifting Service",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 19.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TransportScreen()));
                            },
                            child: const Image(
                              image: AssetImage(
                                'assets/transport.png',
                              ),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.fitWidth,
                            )),
                        //  ],
                      ),
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 5.0, 1.0),
                          child: Text(
                            "On-Demand Home Service",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 19.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const ServiceCatogary1(),
                    const ServiceCatogary2(),
                    const ServiceCatogary3(),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 5.0, 1.0),
                          child: Text(
                            "House Inspection service",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 19.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              customLaunch('tel:+9779851001238');
                            },
                            child: const Image(
                              image: AssetImage(
                                'assets/homeinspection1.png',
                              ),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.fitWidth,
                            )),
                        //  ],
                      ),
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(30.0, 0.0, 5.0, 1.0),
                          child: Text(
                            "Construction & Consultancy Service",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 19.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.black,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              customLaunch('tel:+9779851001238');
                            },
                            child: const Image(
                              image: AssetImage(
                                'assets/Consultancy.png',
                              ),
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.fitWidth,
                            )),
                        //  ],
                      ),
                    ),
                    const Divider(
                      color: Colors.teal,
                      thickness: 0.2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(21.0, 0.0, 5.0, 0.0),
                          child: Text(
                            "Water Tanker Facility",
                            style: GoogleFonts.changa(
                              textStyle: const TextStyle(
                                  color: Color(0xff0E4d92), fontSize: 18.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const UploadTankerUi(),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ))
    ]);
  }
}
