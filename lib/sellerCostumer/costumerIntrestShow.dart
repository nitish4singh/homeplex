import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/rentservice/rentdetail.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/utils/custom_text.dart';


class CostumerIntrestProductWidget extends StatefulWidget {
  final RentModel rentProductModel;
  const CostumerIntrestProductWidget({
    Key? key,
    required this.rentProductModel,
  }) : super(key: key);
  @override
  State<CostumerIntrestProductWidget> createState() =>
      _CostumerIntrestProductWidgetState();
}

class _CostumerIntrestProductWidgetState
    extends State<CostumerIntrestProductWidget> {
  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RentDetail(rentModel: widget.rentProductModel)));
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
              Container(
                color: Colors.grey[100],
                width: 130,
                height: 150,
                child: ClipRRect(
                  child: Image.network(
                    widget.rentProductModel.imagesUrl[0],
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 1.0, 1.0),
                          child: CustomText(
                              text: 'ID:${widget.rentProductModel.uid}',
                              size: 19,
                              color: Colors.red,
                              weight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: CustomText(
                              text:
                                  "Property Owener:${widget.rentProductModel.formuploadername}",
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: CustomText(
                              text: widget.rentProductModel.famousplacenearby,
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: CustomText(
                              text:
                                  "Preference group: ${widget.rentProductModel.family}",
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: 15,
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
                              "Rs.${widget.rentProductModel.rate.toInt()} / Month",
                              style: GoogleFonts.coda(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              widget.rentProductModel.phoneno,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            )),
                      ],
                    ),
                    // ElevatedButton(
                    //     onPressed: () => MapsLauncher.launchCoordinates(lat,
                    //         lon, 'Click on start to navigate on properties '),
                    //     style: ElevatedButton.styleFrom(
                    //         primary: const Color(0xffFF5A36),
                    //         onPrimary: Colors.white,
                    //         onSurface: Colors.grey,
                    //         side:
                    //             const BorderSide(color: Colors.grey, width: 2)),
                    //     child: const Padding(
                    //       padding: EdgeInsets.only(
                    //           top: 8, left: 1, right: 1, bottom: 8),
                    //       child: Text(
                    //         'Go through Map',
                    //         style: TextStyle(
                    //           fontSize: 13.0,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "                      More.....",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 5,
                    )
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
