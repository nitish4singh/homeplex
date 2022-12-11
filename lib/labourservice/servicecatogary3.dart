import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/electricalapplience.dart';
import 'package:Homeplex/labourservice/construction.dart';

class ServiceCatogary3 extends StatefulWidget {
  const ServiceCatogary3({Key? key}) : super(key: key);
  @override
  _ServiceCatogary3State createState() => _ServiceCatogary3State();
}

class _ServiceCatogary3State extends State<ServiceCatogary3> {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ElectricalApplience()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.electric_bolt,
                          color: Color(0xff0E4d92),
                          size: 40.0,
                        ),
                        Text(
                          " Home Applience \n Service",
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConstructionWork()));
              },
              child: Card(
                elevation: 10,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.teal, width: 0.2)),
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  width: 125,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.construction,
                          color: Color(0xff0E4d92),
                          size: 40.0,
                        ),
                        Text(
                          " Construction & \n  flooring Work ",
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
            // const Padding(padding: EdgeInsets.all(3.0)),
            // GestureDetector(
            //   onTap: () {},
            //   child: Card(
            //     elevation: 10,
            //     shadowColor: Colors.black,
            //     color: Colors.white,
            //     shape: const RoundedRectangleBorder(
            //         side: BorderSide(color: Colors.teal, width: 0.2)),
            //     child: Container(
            //       margin: const EdgeInsets.all(2.0),
            //       width: 110,
            //       child: Padding(
            //         padding: const EdgeInsets.all(5.0),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: <Widget>[
            //             Image.asset(
            //               'assets/bed.png',
            //               height: 40,
            //               width: 60,
            //               fit: BoxFit.cover,
            //             ),
            //             const Text(
            //               " Carpentry \n Aluminum ",
            //               style: TextStyle(
            //                 fontFamily: 'SF Rounded',
            //                 fontSize: 13,
            //                 color: Colors.teal,
            //               ),
            //             ),

            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            const Padding(padding: EdgeInsets.all(3.0)),
          ],
        ));
  }
}
