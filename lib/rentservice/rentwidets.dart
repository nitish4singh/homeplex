
import 'package:flutter/material.dart';
import 'package:Homeplex/rentservice/rentdetail.dart';
import 'package:Homeplex/rentservice/rentmodel.dart';

class RentProductWidgets extends StatefulWidget {
  final RentModel rentProductModel;

  const RentProductWidgets({
    Key? key,
    required this.rentProductModel,
  }) : super(key: key);

  @override
  State<RentProductWidgets> createState() => _RentProductWidgetsState();
}

class _RentProductWidgetsState extends State<RentProductWidgets> {
  

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 5, bottom: 5),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RentDetail(rentModel: widget.rentProductModel)));
          },
          child: Container(
            height: 350,
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
                  height: 150,
                  color: Colors.grey[100],
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
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Card(
                          color: Colors.grey[200],
                          margin: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Rate: ${widget.rentProductModel.rate}",
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                "Preference group:  ${widget.rentProductModel.family}",
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                "location :  ${widget.rentProductModel.tracelocation}",
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                "NearBy place:${widget.rentProductModel.famousplacenearby}",
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                "TotalRoom :  ${widget.rentProductModel.totalroom}",
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              const Text(
                                "More.... ",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
