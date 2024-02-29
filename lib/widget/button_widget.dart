import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/widget/normal_text.dart';

Widget buttonWidget({title, color, onPress, textColor}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: color,
          padding: const EdgeInsets.all(14)),
      onPressed: onPress,
      child: boldText(text: title, size: 18.0, color: textColor));
}
