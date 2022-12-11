import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'detail.dart';
import 'model.dart';

class TankerWidgets extends StatefulWidget {
  final TankerModel tankerModel;
  const TankerWidgets({
    Key? key,
    required this.tankerModel,
  }) : super(key: key);

  @override
  State<TankerWidgets> createState() => _TankerWidgetsState();
}

class _TankerWidgetsState extends State<TankerWidgets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 10, bottom: 10),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TankerDetails(tankerModel: widget.tankerModel)));
          },
          child: Container(
            height: 190,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400]!,
                      offset: const Offset(-2, -1),
                      blurRadius: 5),
                ]),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colors.grey[200],
                  width: 130,
                  height: 150,
                  child: ClipRRect(
                    child: Image.network(
                      widget.tankerModel.url,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Card(
                              color: Colors.grey[200],
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Id: ${widget.tankerModel.uid}",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.red),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Tanker area: ${widget.tankerModel.targetarea}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Driver Name: ${widget.tankerModel.drivername}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Capacity:  ${widget.tankerModel.capacity}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Cost:${widget.tankerModel.kmprice}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Tanker no:${widget.tankerModel.vehicalname}",
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  const Text(
                                    "More.... ",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 5,
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    heightFactor: 0.7,
                    widthFactor: 1,
                    child: AlignPositioned(
                      moveByContainerWidth: -0.1,
                      touch: Touch.inside,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        color: Colors.orange,
                        child: Container(
                          color: Colors.red,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
