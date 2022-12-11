import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class Greetings extends StatefulWidget {
  const Greetings({Key? key}) : super(key: key);

  @override
  _GreetingsState createState() => _GreetingsState();
}
class _GreetingsState extends State<Greetings> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 25,
      bottom: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:const  EdgeInsets.fromLTRB(80, 1, 0, 0),
              child: Text('Talk to Expert',
                style: GoogleFonts.changa(
                  textStyle: const TextStyle(color: Colors.white
                      , fontSize: 23.0),
                ),
              )),
        ],
      ),
    );
  }
}
void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
  //  print(' could not launch $command');
  }
}

