import 'package:flutter/cupertino.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension SysPaddingEx on Widget {
  Widget pad(
      {double top = 0,
        double right = 0,
        double left = 0,
        double bottom = 0}) =>
      Padding(
        padding:
        EdgeInsets.only(top: top, right: right, left: left, bottom: bottom),
        child: this,
      );
}