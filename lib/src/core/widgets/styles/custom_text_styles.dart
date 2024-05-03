//Open Sans Bold
import 'package:flutter/material.dart';

TextStyle openSansBoldText({Color? color, double? fontSize}) {
  return TextStyle(
    fontFamily: 'OpenSans',
    color: color ?? Colors.black,
    fontSize: fontSize ?? 14,
    fontWeight: FontWeight.w700,
  );
}

//Open Sans ExtraBold
TextStyle openSansExtraBoldText({Color? color, double? fontSize}) {
  return TextStyle(
    fontFamily: 'OpenSans',
    color: color ?? Colors.black,
    fontSize: fontSize ?? 14,
    fontWeight: FontWeight.w900,
  );
}

//Open Sans Medium
TextStyle openSansMedium({Color? color, double? fontSize}) {
  return TextStyle(
    fontFamily: 'OpenSans',
    color: color ?? Colors.black,
    fontSize: fontSize ?? 14,
    fontWeight: FontWeight.w500,
  );
}

TextStyle openSansRegular({Color? color, double? fontSize}) {
  return TextStyle(
    fontFamily: 'OpenSans',
    color: color ?? Colors.black,
    fontSize: fontSize ?? 14,
  );
}

TextStyle openSansSemiBold({Color? color, double? fontSize}) {
  return TextStyle(
    fontFamily: 'OpenSans',
    color: color ?? Colors.black,
    fontSize: fontSize ?? 14,
    fontWeight: FontWeight.w600,
  );
}

TextStyle starWarsFont({Color? color, double? fontSize}) {
  return TextStyle(
    fontFamily: 'StarWars',
    color: color ?? Colors.black,
    fontSize: fontSize ?? 14,
  );
}

TextStyle customOutlinedTextStyle() {
  return const TextStyle(shadows: [
    Shadow(
        // bottomLeft
        offset: Offset(-1.5, -1),
        color: Colors.black),
    Shadow(
        // bottomRight
        offset: Offset(1.5, -1),
        color: Colors.black),
    Shadow(
        // topRight
        offset: Offset(1, 1),
        color: Colors.black),
    Shadow(
        // topLeft
        offset: Offset(-1, 1),
        color: Colors.black),
  ]);
}
