import 'package:flutter/material.dart';
import '../uploadProperties/appartment.dart';
import '../uploadProperties/shop_shutter.dart';

class Properties2 extends StatefulWidget {
  const Properties2({Key? key}) : super(key: key);
  @override
  Properties2State createState() => Properties2State();
}

class Properties2State extends State<Properties2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 170,
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(3.0)),
            Container(
                padding: const EdgeInsets.all(1.0),
                width: 120,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.blue, width: 0.3),
                  ),
                  shadowColor: Colors.blue,
                  color: Colors.grey[200],
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        TextButton(
                          child: Image.asset(
                            'assets/shutter.png',
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ShutterUploadScreen()));
                          },
                        ),
                        Text(
                          "shop \n shutter",
                          style: TextStyle(
                            fontFamily: 'SF Rounded',
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const Padding(padding: EdgeInsets.all(3.0)),
            Container(
                padding: const EdgeInsets.all(1.0),
                width: 120,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(color: Colors.blue, width: 0.3),
                  ),
                  shadowColor: Colors.blue,
                  color: Colors.grey[200],
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        TextButton(
                          child: Image.asset(
                            'assets/appartment.png',
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AppartmentUploadScreen()));
                          },
                        ),
                        Text(
                          " Appartment",
                          style: TextStyle(
                            fontFamily: 'SF Rounded',
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
