import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:Homeplex/widgets/loading.dart';
import '../layout/color.dart';
import 'first_screen_transport.dart';

class UploadTransportUi extends StatefulWidget {
  const UploadTransportUi({Key? key}) : super(key: key);

  @override
  UploadTransportUiState createState() => UploadTransportUiState();
}

class UploadTransportUiState extends State<UploadTransportUi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 3),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 3.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: AspectRatio(
        aspectRatio: 2.3 / 1,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              shadowColor: AppTheme.primary,
              margin: const EdgeInsets.all(5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                    color: Color(0xFF0041A8),
                  )),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(-2, -1),
                              blurRadius: 3),
                        ]),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              children: <Widget>[
                                const Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Loading(),
                                )),
                                Center(
                                  child: Image.asset(
                                    ('assets/truck.png'),
                                    height: 110,
                                    //fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text:
                                      'All type vehical \n for shifting  House',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ], style: TextStyle(color: Color(0xff0E4d92))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //TransportScreen
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TransportScreen()));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xff0E4d92)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Icon(
                                    Icons.emoji_transportation,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Take in rent',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashFactory: InkRipple.splashFactory,
                        splashColor: AppTheme.shadow.withOpacity(0.1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TransportScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 5,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                heightFactor: 0.7,
                widthFactor: 1,
                child: AlignPositioned(
                  moveByContainerWidth: -0.01,
                  touch: Touch.inside,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    color: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
