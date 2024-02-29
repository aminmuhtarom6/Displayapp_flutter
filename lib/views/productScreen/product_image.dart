import 'package:display_app_flutter/const/const.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .roundedLg
      .color(lightGrey)
      .size(100, 100)
      .make();
}
