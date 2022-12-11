import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Homeplex/rentservice/rentdetail.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';
import 'package:Homeplex/utils/custom_text.dart';

class ResultsWidget extends StatelessWidget {
  final RentModel productModel;
  const ResultsWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RentDetail(rentModel: productModel),
          ),
        );
      },
      child: Container(
        height: 330,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400]!,
                  offset: const Offset(-1, 1),
                  blurRadius: 7),
            ]),
        child: Column(
          children: <Widget>[
            Container(
              width: 350,
              height: 160,
              color: Colors.grey[100],
              child: ClipRRect(
                child: Image.network(
                  productModel.imagesUrl[0],
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
            Expanded(
              child: Column(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                              child: Text(
                                "Rate :",
                                style: GoogleFonts.coda(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Rs.${productModel.rate.toInt()} / Month",
                                style: GoogleFonts.coda(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 20.0),
                                ),
                              )),
                        ],
                      )),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 3.0, 1.0, 1.0),
                        child: CustomText(
                            text: 'ID:${productModel.uid}',
                            size: 20,
                            weight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${productModel.tracelocation}\n',
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text:
                                    "Nearby place :${productModel.famousplacenearby} \n",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text:
                                    "Uploder Name :${productModel.formuploadername} \n",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                            const TextSpan(
                              text: "More......",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 17.0),
                            ),
                          ], style: const TextStyle(color: Colors.black)),
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
    );
  }
}
