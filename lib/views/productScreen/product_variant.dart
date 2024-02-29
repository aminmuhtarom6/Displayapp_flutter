import 'package:display_app_flutter/const/colors.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/controller/variant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

Widget productVariant( ProductController controller) {
  return Obx(
    () => Padding(
      padding: const EdgeInsets.all(8.0),
      child: MultiSelectDialogField(
          decoration: const BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          listType: MultiSelectListType.LIST,
          items: controller.variants
              .map((variants) =>
                  MultiSelectItem<Variants>(variants, variants.variant!))
              .toList(),
          selectedColor: purpleColor,
          title: const Text("Select Variants"),
          onConfirm: (newValue) {
            controller.selectedVariant = newValue;
            controller.selectVariantindex.value = newValue.toString();
          }),
    ),
  );
}
