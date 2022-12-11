import 'package:flutter/material.dart';
const mainBgColor = Color(0xFFf2f2f2);
const darkColor = Color(0xff0E4d92);
const midColor = Color(0xff0E4d92);
const lightColor = Color(0xff0E4d92);
const darkRedColor = Color(0xff0E4d92);
const lightRedColor = Color(0xff0E4d92);
const purpleGradient = LinearGradient(
  colors: <Color>[darkColor, midColor, lightColor],
  stops: [0.0, 0.5, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const redGradient = LinearGradient(
  colors: <Color>[darkRedColor, lightRedColor],
  stops: [0.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

