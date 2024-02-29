import 'package:display_app_flutter/const/const.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).rounded.padding(const EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(fontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: red,
                )
              : Container()
        ],
      ),
    ),
  );
}
