import 'package:display_app_flutter/const/const.dart';
// ignore: depend_on_referenced_packages

Widget chatBubble() {
  // var t = data['created_on']== null? DateTime.now(): data['created_on'].toDate();
  // var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          color: green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Text message".text.white.size(16).make(),
          10.heightBox,
          "10.00 Pm ".text.make(),
        ],
      ),
    ),
  );
}
