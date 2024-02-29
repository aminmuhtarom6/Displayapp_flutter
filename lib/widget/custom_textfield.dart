import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/widget/normal_text.dart';

Widget customTextField(
    {label, hint, controller, isDesc = false, obscureText = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    obscureText: obscureText,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: boldText(text: label, color: white, size: 16.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: lightPurpleColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        hintText: hint,
        hintStyle: const TextStyle(
            color: lightGrey, fontSize: 16, fontWeight: FontWeight.w400)),
  );
}
