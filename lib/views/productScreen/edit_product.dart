import 'package:flutter/cupertino.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/views/productScreen/product_dropdown.dart';
import 'package:display_app_flutter/views/productScreen/product_image.dart';
import 'package:display_app_flutter/widget/custom_textfield.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  final String? name;
  final String? desc;
  final String? qty;
  final String? price;
  const EditProduct({super.key, this.name, this.desc, this.qty, this.price});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
    var controller = Get.find<ProductController>();
    @override
  void initState() {
    controller.pnameController.text = widget.name!;
    controller.ppriceController.text = widget.price!;
    controller.pqtyController.text = widget.qty!;
    controller.pdescController.text = widget.desc!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

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
          title: boldText(text: "${controller.snapshotData['p_name']}", size: 16.0, color: white),
          actions: [
            controller.isLoading.value
                ? loadingCupertino(circleColor: white)
                : CupertinoButton(
                    pressedOpacity: 0.2,
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImagesProducts();
                      // ignore: use_build_context_synchronously
                      await controller.updateProduct(controller.snapshotData.id);
                    },
                    child: const Icon(
                      Icons.update_rounded,
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
                    label: controller.snapshotData['p_name'],
                    hint: "Nama Produk",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    label: controller.snapshotData['p_price'],
                    hint: "Harga Produk",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    label: controller.snapshotData['p_qty'],
                    hint: "Kuantiti Produk",
                    controller: controller.pqtyController),
                10.heightBox,
                customTextField(
                    label: controller.snapshotData['p_description'],
                    hint: "Deskripsi Produk",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                productDropDown(
                    "${controller.snapshotData['p_category']}",
                    controller.pCategoryList,
                    controller.categoryValue,
                    controller),
                10.heightBox,
                productDropDown(
                    "${controller.snapshotData['p_subcategory']}",
                    controller.pSubCategoryList,
                    controller.subcategoryValue,
                    controller),
                20.heightBox,
                boldText(
                    text: "Choose product images", color: white, size: 18.0),
                5.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.snapshotData['p_imgs'][index] != '' && controller.pImagesList[index] != null
                            ? Image.network(
                                controller.snapshotData['p_imgs'][index],
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
                boldText(
                    text: "Add product variant", color: lightGrey, size: 18.0),
                20.heightBox,
                customTextField(
                    hint: "Varian Produk",
                    label: "Varian Produk",
                    controller: controller.pVariantController),
                15.heightBox,
                ElevatedButton.icon(
                    label: "Add Variant".text.purple900.bold.size(18).make(),
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.add_circled_solid,
                      color: purpleColor,
                    )).box.rounded.size(200, 50).make(),
                5.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
