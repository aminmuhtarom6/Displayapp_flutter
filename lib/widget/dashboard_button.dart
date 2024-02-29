import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/widget/normal_text.dart';

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          boldText(text: title, size: 16.0, color: white),
          10.heightBox,
          boldText(text: count, size: 16.0, color: white),
        ],
      ),
      Image.asset(
        icon,
        width: 40,
      ).box.rounded.shadowOutline(outlineColor: lightPurpleColor).make()
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
