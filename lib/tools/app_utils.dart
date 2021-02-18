import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppUtils {
  static final Icon backButton = Icon(
    Icons.arrow_back_ios_outlined,
    color: Colors.blueGrey,
    size: 25,
  );

  static final BoxDecoration foreGroundDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.white,
        Colors.grey.withOpacity(0.1),
        Colors.transparent,
      ],
      begin: Alignment(0, 1),
      end: Alignment(0, -1),
    ),
  );

  static final BoxDecoration foreGroundDecoration1 = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.transparent,
        Colors.grey
            .withOpacity(0.2),
        Colors.white,
      ],
      begin: Alignment(0, -1),
      end: Alignment(0, 1),
    ),
  );
}
