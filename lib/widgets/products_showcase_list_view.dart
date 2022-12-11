import 'package:flutter/material.dart';

class ProductsShowcaseListView extends StatelessWidget {
  //final String title;

  final List<Widget> children;
  const ProductsShowcaseListView({
    Key? key,
   // required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          Column(children: children)
      ],
    );
  }
}
