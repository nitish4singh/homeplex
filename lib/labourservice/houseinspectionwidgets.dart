import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/labourservice/houseinspectiondetail.dart';
import 'package:Homeplex/labourservice/houseinspectionmodel.dart';
import 'package:Homeplex/widgets/loading.dart';

class HouseInspectionWidets extends StatefulWidget {
  final HomeInspectionModel homeInspectionModel;

  const HouseInspectionWidets({
    Key? key,
    required this.homeInspectionModel,
  }) : super(key: key);

  @override
  State<HouseInspectionWidets> createState() => _HouseInspectionWidetsState();
}

class _HouseInspectionWidetsState extends State<HouseInspectionWidets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Houseinspectiondetail(
                      homeInspectionModel: widget.homeInspectionModel)));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[350]!,
                    offset: const Offset(-2, -1),
                    blurRadius: 5),
              ]),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      const Positioned.fill(
                          child: Align(
                        alignment: Alignment.center,
                        child: Loading(),
                      )),
                      Center(
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: const Color(0xff0E4d92),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.homeInspectionModel.image,
                            ),
                            radius: 41.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Service Charge :${widget.homeInspectionModel.servicecharge} \n',
                            style: GoogleFonts.oswald(
                              textStyle: const TextStyle(
                                  color: Colors.red, fontSize: 18.0),
                            ),
                          ),
                          TextSpan(
                              text:
                                  '${widget.homeInspectionModel.engineername} \n',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              )),
                          TextSpan(
                              text:
                                  ' ${widget.homeInspectionModel.engineeringtype} \n',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              )),
                          TextSpan(
                              text:
                                  ' ${widget.homeInspectionModel.speciality} \n',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              )),
                          TextSpan(
                              text:
                                  ' Exprerience : ${widget.homeInspectionModel.experience} \n',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              )),
                        ],
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: const Color(0xff9b0b79),
                        onSurface: Colors.grey,
                      ),
                      child: const Text(
                        '  Request for visit  ',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Houseinspectiondetail(
                                    homeInspectionModel:
                                        widget.homeInspectionModel)));
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
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
