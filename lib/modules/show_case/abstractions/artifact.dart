import 'package:flutter/material.dart';

abstract class Artifact {
  double get width;
  double get heigth;
  double get radius;
  Widget get body;

  set width(double width);
  set heigth(double heigth);
  set radius(double radius);
  set body(Widget body);
}
