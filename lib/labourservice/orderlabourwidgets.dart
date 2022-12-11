import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/uploadlabour.dart';
import 'package:Homeplex/transportation/name.dart';

class CostumerlabourOrderWidets extends StatefulWidget {
  final LabourOrder labourOrder;

  const CostumerlabourOrderWidets({
    Key? key,
    required this.labourOrder,
  }) : super(key: key);

  @override
  State<CostumerlabourOrderWidets> createState() =>
      _CostumerlabourOrderWidetsState();
}

class _CostumerlabourOrderWidetsState extends State<CostumerlabourOrderWidets> {
  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.parse(widget.labourOrder.pickupdate);
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
                            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: Text(
                              'OrderId :  ${widget.labourOrder.orderid}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 19),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 5, 0, 0),
                                child: Text(
                                  'LabourType:  ${widget.labourOrder.labourtype}',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 0),
                            child: Text(
                              'servicetime:  ${widget.labourOrder.servicetime}',
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
                            ' Your Address:   ${widget.labourOrder.tracelocation}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 5.0, 1.0, 1.0),
                              child: Text(
                                'Date of Pickup:  $formate1',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 17),
                              )),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                          child: Text(
                            "servicetime:  ${widget.labourOrder.servicetime}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "For cancellation contact",
                              style: GoogleFonts.coda(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              ),
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 1.0),
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
