import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/rentservice/bhakatpur.dart';
import 'package:Homeplex/rentservice/lalitpurfirstscreen.dart';
import '../rentservice/kathmandufirstscreen.dart';

class RentServices extends StatelessWidget {
  const RentServices({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 11, top: 10, right: 7, bottom: 10),
        height: 150,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(1),
              topRight: Radius.circular(1),
              bottomLeft: Radius.circular(1),
              bottomRight: Radius.circular(1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              spreadRadius: 3,
              blurRadius: 1,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 8, left: 0, right: 4, bottom: 10),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                    color: Colors.grey[500]!,
                  )
                ],
              ),
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KtmFirstScreen()));
                      },
                      child: Image.asset(
                        'assets/kathmandu.jpg',
                        height: 100,
                        //width: 80,
                        fit: BoxFit.cover,
                      ),
                      //KathmanduScreen
                    ),
                    Text(
                      ' Kathmandu',
                      style: GoogleFonts.baloo2(
                        textStyle: const TextStyle(
                            color: Colors.black, fontSize: 18.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey[500]!,
                  )
                ],
              ),
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      child: Image.asset(
                        'assets/lalitpur.jpg',
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LalitpurFirstScreen()));
                      },
                    ),
                    Text(
                      ' Lalitpur',
                      style: GoogleFonts.baloo2(
                        textStyle: const TextStyle(
                            color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(2, 1, 1, 0)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Colors.grey[200]!,
                  )
                ],
              ),
              width: 150,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(1, 5, 1, 0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      child: Image.asset(
                        'assets/bhaktapur.jpg',
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BhaktpurFirstScreen()));
                      },
                    ),
                    Text(
                      'Bhaktapur',
                      style: GoogleFonts.baloo2(
                        textStyle: const TextStyle(
                            color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                    // Text(
                    //   ' FLAT 15% off',
                    //   style: GoogleFonts.oswald(
                    //     textStyle: TextStyle(
                    //         color: Colors.red, fontSize: 16.0),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
