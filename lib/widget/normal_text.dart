import 'package:display_app_flutter/const/const.dart';

Widget normalText({text, color, size=14.0 }){
  return "$text".text.color(color).size(size).make();
}

Widget boldText({text, color, size=14.0 }){
  return "$text".text.semiBold.color(color).size(size).make();
}