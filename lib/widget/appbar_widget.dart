import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title) {
  return AppBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    backgroundColor: purpleColor,
    shadowColor: lightPurpleColor,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: white, size: 18.0),
    actions: [
      Center(
          child: boldText(
              text:
                  intl.DateFormat('EEE, MMM d,' 'yyyy').format(DateTime.now()),
              color: white)),
      10.heightBox,
      10.widthBox,
    ],
  );
}
