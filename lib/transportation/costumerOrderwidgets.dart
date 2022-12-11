import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/transportation/name.dart';
import 'package:Homeplex/transportation/ordertransport.dart';
import 'package:Homeplex/utils/custom_text.dart';

class CostumerOrderWidets extends StatefulWidget {
  final TransportOrder transportOrder;
  const CostumerOrderWidets({
    Key? key,
    required this.transportOrder,
  }) : super(key: key);
  @override
  State<CostumerOrderWidets> createState() => _CostumerOrderWidetsState();
}

class _CostumerOrderWidetsState extends State<CostumerOrderWidets> {
  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(widget.transportOrder.pickupdate);
    var formate1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
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
                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
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
                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                            child: Text(
                              'Driver no :  ${widget.transportOrder.driverphoneno}',
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
                            child: Text(
                              'Driver Name:  ${widget.transportOrder.drivername}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
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
                                const EdgeInsets.fromLTRB(10.0, 5.0, 1.0, 1.0),
                            child: Text(
                              ' Your Address:  ${widget.transportOrder.deliverylocation}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
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
                                const EdgeInsets.fromLTRB(10.0, 5.0, 1.0, 1.0),
                            child: CustomText(
                                text: 'Date of Pickup:  $formate1',
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
                                const EdgeInsets.fromLTRB(10.0, 5.0, 1.0, 1.0),
                            child: Text(
                              'pickupTime: ${widget.transportOrder.pickuptime}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
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
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 1.0, 1.0),
                          child: Text(
                            "Labour Facility:${widget.transportOrder.labourneed}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 5.0, 1.0, 1.0),
                            child: Text(
                              'Labour Rate: ${widget.transportOrder.labourcharge}',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "For enquiry, Contact",
                              style: GoogleFonts.coda(
                                textStyle: const TextStyle(
                                    color: Colors.red, fontSize: 18.0),
                              ),
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 5.0),
                          child: Card(
                            shadowColor: Colors.grey,
                            margin: const EdgeInsets.all(1),
                            child: TextButton(
                              onPressed: () {
                                customLaunch('tel:+9779862287720');
                              },
                              child: const Icon(
                                Icons.phone_in_talk_rounded,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
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
