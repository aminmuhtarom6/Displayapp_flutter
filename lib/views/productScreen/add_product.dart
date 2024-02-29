import 'package:flutter/cupertino.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/views/productScreen/product_dropdown.dart';
import 'package:display_app_flutter/views/productScreen/product_image.dart';
import 'package:display_app_flutter/widget/custom_textfield.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: purpleColor,
          shadowColor: lightPurpleColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              )),
          title: boldText(text: "Tambah Produk", size: 16.0, color: white),
          actions: [
            controller.isLoading.value
                ? loadingCupertino(circleColor: white)
                : CupertinoButton(
                    pressedOpacity: 0.2,
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImagesProducts();
                      // ignore: use_build_context_synchronously
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: const Icon(
                      CupertinoIcons.add_circled_solid,
                      color: white,
                    ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.heightBox,
                customTextField(
                    hint: "Nama Produk",
                    label: "Nama Produk",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "Harga Produk",
                    label: "Harga Produk",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "Kuantiti Produk",
                    label: "Kuantiti Produk",
                    controller: controller.pqtyController),
                    20.heightBox,
                customTextField(
                    hint: "Varian Produk",
                    label: "Varian Produk",
                    controller: controller.pVariantController),
                10.heightBox,
                customTextField(
                    hint: "Deskripsi Produk",
                    label: "Deskripsi Produk",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                productDropDown("Category", controller.pCategoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropDown("SubCategory", controller.pSubCategoryList,
                    controller.subcategoryValue, controller),
                20.heightBox,
                boldText(
                    text: "Choose product images", color: white, size: 18.0),
                5.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                width: 100,
                              ).onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "+").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                20.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: white),
                30.heightBox,

                // boldText(
                //     text: "Add product variant", color: lightGrey, size: 18.0),
                
                15.heightBox,
                // ElevatedButton.icon(
                //     label: "Add Variant".text.purple900.bold.size(18).make(),
                //     onPressed: () {},
                //     icon: const Icon(
                //       CupertinoIcons.add_circled_solid,
                //       color: purpleColor,
                //     )).box.rounded.size(200, 50).make(),

                5.heightBox,
                // Obx(
                //   () => Wrap(
                //     spacing: 5.0,
                //     runSpacing: 5.0,
                //     children: List.generate(
                //         14,
                //         (index) =>
                //             // ignore: unnecessary_brace_in_string_interps
                //             VxBox(
                //                     child: controller
                //                                 .selectVariantindex.value ==
                //                             index
                //                         // ignore: unnecessary_brace_in_string_interps
                //                         ? "${index}"
                //                             .text
                //                             .white
                //                             .bold
                //                             .makeCentered()
                //                         : const SizedBox())
                //                 .color(Vx.randomPrimaryColor)
                //                 .roundedFull
                //                 .size(50, 50)
                //                 .make()
                //                 .onTap(() {
                //               controller.selectVariantindex.value = index;
                //             })),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
