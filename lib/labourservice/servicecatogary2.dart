import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/carpentry.dart';
import 'package:Homeplex/labourservice/cleaning.dart';
import 'package:Homeplex/labourservice/painting.dart';

class ServiceCatogary2 extends StatefulWidget {
  const ServiceCatogary2({Key? key}) : super(key: key);

  @override
  _ServiceCatogary2State createState() => _ServiceCatogary2State();
}

class _ServiceCatogary2State extends State<ServiceCatogary2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 3),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cleaning()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 115,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.cleaning_services,
                          color: Color(0xff0E4d92),
                          size: 40.0,
                        ),
                        Text(
                          " Cleaning ",
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                color: Colors.teal, fontSize: 13.0),
                          ),
                        ),
                        const Text(
                          "All service",
                          style: TextStyle(
                            fontFamily: 'SF Rounded',
                            fontSize: 11,
                            color: Color(0xff0E4d92),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(3.0)),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Carpentry()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 118,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.carpenter,
                          color: Color(0xff0E4d92),
                          size: 40.0,
                        ),
                        Text(
                          " Carpentry \n Aluminum ",
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                color: Colors.teal, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(3.0)),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Painting()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 122,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.format_paint_outlined,
                          color: Color(0xff0E4d92),
                          size: 40.0,
                        ),
                        Text(
                          " Painting  Wallpaper \n Installation ",
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                color: Colors.teal, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(3.0)),
          ],
        ));
  }
}
