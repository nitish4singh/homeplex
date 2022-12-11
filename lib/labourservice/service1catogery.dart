import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/electrical.dart';
import 'package:Homeplex/labourservice/motor.dart';
import 'package:Homeplex/labourservice/plumber.dart';

class ServiceCatogary1 extends StatefulWidget {
  const ServiceCatogary1({Key? key}) : super(key: key);

  @override
  _ServiceCatogary1State createState() => _ServiceCatogary1State();
}

class _ServiceCatogary1State extends State<ServiceCatogary1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Plumber()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 110,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.plumbing,
                          color: Color(0xff0E4d92),
                          size: 45.0,
                        ),
                        Text(
                          " Plumber ",
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Electrical()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 110,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.electrical_services,
                          color: Color(0xff0E4d92),
                          size: 45.0,
                        ),
                        Text(
                          " Electrical ",
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
                    MaterialPageRoute(builder: (context) => const Motor()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 110,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset(
                          'assets/motor.png',
                          height: 40,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          " Motor  ",
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
          ],
        ));
  }
}
