import 'package:flutter/material.dart';
import 'package:Homeplex/model/flat.dart';
import 'package:Homeplex/utils/custom_text.dart';

class SimpleFlatWidget extends StatelessWidget {
  final FlatModel flatModel;
  const SimpleFlatWidget({
    Key? key,
    required this.flatModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 15),
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             FlatScreen(flatModel: flatModel)));
          },
          child: Container(
            height: 130,
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
                // const Padding(padding: EdgeInsets.fromLTRB(2, 15, 0, 0)),
                Container(
                  padding: const EdgeInsets.all(1.0),
                  width: 130,
                  height: 150,
                  child: ClipRRect(
                    child: Image.network(
                      flatModel.url,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                            child: CustomText(
                              text: flatModel.productName,
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 2, 0, 0),
                            child: Text(
                              "${flatModel.cost.toDouble()} Tests",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                            child: Text(
                              "Rs${flatModel.uid}",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 17),
                            ),
                          ),
                          // Padding(
                          //     padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                          //     child: Card(
                          //         child: CustomText(
                          //       text: " ${flatModel.discount}% ",
                          //       size: 15,
                          //       weight: FontWeight.w400,
                          //       color: Colors.red,
                          //     ))),
                        ],
                      ),

                      // FlatButton(
                      //      shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       side:const  BorderSide(color: Colors.black)
                      //   ),
                      //   padding:const  EdgeInsets.only(top: 10, left:10,right:10,bottom: 10),
                      //   color:const  Color(0xff9b0b79),
                      //   hoverColor: Colors.red,
                      //   textColor: Colors.white,
                      //   child:const  Text('Book  a Test',
                      //     style:  TextStyle(
                      //       fontSize: 13.0,
                      //       color: Colors.white,
                      //     ),),
                      //   onPressed: (){
                      //    // changeScreen(context, LabTestFlat(labTestFlat: labTestflat,));
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
