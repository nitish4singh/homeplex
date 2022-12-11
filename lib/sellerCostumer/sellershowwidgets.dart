import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/resources/seller.dart';
import 'package:Homeplex/utils/custom_text.dart';

class SellerProductWidget extends StatelessWidget {
  final RentModel rentProductModel;

  const SellerProductWidget({
    Key? key,
    required this.rentProductModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             ProductScreen(rentProductModel: rentProductModel)));
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
                height: 190,
                child: ClipRRect(
                  child: Image.network(
                    rentProductModel.imagesUrl[0],
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
                              text: 'ID:${rentProductModel.uid}',
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
                              text: rentProductModel.formuploadername,
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: CustomText(
                              text: rentProductModel.tracelocation,
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
                              "TotalRoom.${rentProductModel.totalroom.toInt()} ",
                              style: GoogleFonts.coda(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Rs.${rentProductModel.rate.toInt()} / Month",
                              style: GoogleFonts.coda(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              rentProductModel.phoneno,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            )),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        CloudFirestoreSellerClass().deleteProductofSeller(
                            id: firebaseAuth.currentUser!.uid);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xffFF5A36),
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          side: const BorderSide(color: Colors.grey, width: 2)),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 8, left: 1, right: 1, bottom: 8),
                        child: Text(
                          'Delete your post',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
