import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:Homeplex/transportation/ordertransport.dart';
import 'package:Homeplex/utils/custom_text.dart';

import '../phone.dart';

class DriverOrderWidets extends StatefulWidget {
  final TransportOrder transportOrder;

  const DriverOrderWidets({
    Key? key,
    required this.transportOrder,
  }) : super(key: key);

  @override
  State<DriverOrderWidets> createState() => _DriverOrderWidetsState();
}

class _DriverOrderWidetsState extends State<DriverOrderWidets> {
  @override
  Widget build(BuildContext context) {
    final double lat = widget.transportOrder.latitude;
    final double lon = widget.transportOrder.longitude;
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) =>
          //               RentDetail(rentModel: widget.rentProductModel)));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500]!,
                    offset: const Offset(-2, -1),
                    blurRadius: 5),
              ]),
          child: Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(2, 15, 0, 0),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: Text(
                              'OrderId :  ${widget.transportOrder.orderid}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 19),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: Text(
                              'Phone no :  ${widget.transportOrder.phone}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 5, 0, 0),
                            child: CustomText(
                              text:
                                  'Name:  ${widget.transportOrder.costumername}',
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: 17,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 1.0, 1.0),
                            child: CustomText(
                                text:
                                    'Address:  ${widget.transportOrder.deliverylocation}',
                                size: 18,
                                weight: FontWeight.normal),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 1.0, 1.0),
                            child: CustomText(
                                text:
                                    'Date:  ${widget.transportOrder.pickupdate.toString()}',
                                size: 18,
                                weight: FontWeight.normal),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 10.0, 1.0, 1.0),
                            child: CustomText(
                                text:
                                    'pickupTime:  ${widget.transportOrder.pickuptime}',
                                size: 18,
                                weight: FontWeight.normal),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "labour:${widget.transportOrder.labourneed}",
                              style: GoogleFonts.coda(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            )),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(70.0, 0.0, 5.0, 5.0),
                          child: Card(
                            shadowColor: Colors.grey,
                            margin: const EdgeInsets.all(1),
                            child: TextButton(
                              onPressed: () {
                                customLaunch(
                                    'tel:+977${widget.transportOrder.phone}');
                              },
                              child: const Icon(
                                Icons.phone_in_talk_rounded,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40.0,
                        ),
                        ElevatedButton(
                            onPressed: () => MapsLauncher.launchCoordinates(
                                lat,
                                lon,
                                'Click on start to navigate on properties '),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xffFF5A36),
                                onPrimary: Colors.white,
                                onSurface: Colors.grey,
                                side: const BorderSide(
                                    color: Colors.grey, width: 2)),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  top: 8, left: 1, right: 1, bottom: 8),
                              child: Text(
                                'Go through Map',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
