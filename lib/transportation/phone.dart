import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  //  MoodsSelector({Key key}) : super(key: key);
  @override
  PhoneState createState() => PhoneState();
}

class PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                onPressed: () {
                  customLaunch('tel:+9779842435463');
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xffFF5A36),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    side: const BorderSide(color: Colors.grey, width: 2)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 8, left: 1, right: 1, bottom: 8),
                  child: Icon(
                    Icons.phone,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
              )
              //  ),
              ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            //  child: Card(
            //   shadowColor: Colors.red,
            child: TextButton(
        
              onPressed: () {
                customLaunch('sms:+9779842435463');
              },
               style: ElevatedButton.styleFrom(
                    primary: const Color(0xffFF5A36),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    side: const BorderSide(color: Colors.grey, width: 2)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 8, left: 1, right: 1, bottom: 8),
                

              child:  Icon(
                Icons.mail_outline,
                size: 40,
                color: Colors.red,
              ),
            ),),
            //  ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            //  child: Card(
            // shadowColor: Colors.red,
            child: TextButton(
                         onPressed: () {
                customLaunch(
                    'mailto:nitishsingh47@gmail.com?subject=your%20subject&body=Gharx%20is%20developed%20by%20Smarttrix');
              },
               style: ElevatedButton.styleFrom(
                    primary: const Color(0xffFF5A36),
                    onPrimary: Colors.white,
                    onSurface: Colors.grey,
                    side: const BorderSide(color: Colors.grey, width: 2)),
                child: const Padding(
                  padding:
                      EdgeInsets.only(top: 8, left: 1, right: 1, bottom: 8),
                  
              child:  Icon(
                Icons.alternate_email,
                size: 40,
                color: Colors.red,
              ),
            ),)
            // ),
          ),
        ],
      ),
    );
  }
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    // print(' could not launch $command');
  }
}
