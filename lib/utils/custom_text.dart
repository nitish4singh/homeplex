
import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String ?text;
  final double ?size;
  final Color ?color;
  final FontWeight? weight;

   CustomText({Key? key, @required this.text, this.size,this.color,this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),style: TextStyle(fontSize: size ?? 16, color: color, fontWeight: weight ?? FontWeight.normal),
    );
  }
}