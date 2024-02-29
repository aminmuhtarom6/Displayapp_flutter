import 'package:flutter/cupertino.dart';
import 'package:display_app_flutter/const/const.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(red),
  );
}

Widget loadingCupertino({circleColor=red }) {
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      // Cupertino activity indicator with custom radius and color.
      CupertinoActivityIndicator(radius: 20.0, color: circleColor),
    ],
  );
}
