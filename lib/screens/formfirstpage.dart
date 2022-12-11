import 'package:flutter/material.dart';
import 'package:Homeplex/uploadProperties/room.dart';
import '../uploadProperties/flat.dart';
import '../uploadProperties/house.dart';

class Properties1 extends StatefulWidget {
  const Properties1({Key? key}) : super(key: key);
  @override
  Properties1State createState() => Properties1State();
}

class Properties1State extends State<Properties1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
                width: 120,
                margin: const EdgeInsets.all(1.0),
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
                              'assets/building.png',
                              fit: BoxFit.cover,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HouseUploadScreen()));
                            }),
                        Text(
                          "House",
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
                //height: 80,
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
                              'assets/flat.png',
                              fit: BoxFit.cover,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FlatUploadScreen()));
                            }),
                        Text(
                          "Flat",
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
                            'assets/room1.jpg',
                            //height: 300,
                            fit: BoxFit.cover,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RoomUploadScreen()));
                          },
                        ),
                        Text(
                          "Room",
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



//ENGINEER /EXPERT FOR NEW CONSTRUCTION & CONSULTANCY SERVICE