import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

Widget productDropDown(hint, List<String> list, dropvalue, ProductController controller){
  return Obx(()=>
   DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue.value == ''? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e){
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make());
        }).toList(), 
        onChanged: (newValue){
          if(hint == "Category"){
            controller.subcategoryValue.value='';
            controller.populateSubCategoryList(newValue.toString());
          }
          dropvalue.value = newValue.toString();
        }),
    ).box.white.rounded.padding(const EdgeInsets.all(4)).make(),
  );
}