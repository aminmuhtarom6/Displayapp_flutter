import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/profile_controller.dart';
import 'package:display_app_flutter/widget/custom_textfield.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: lightPurpleColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              )),
          title: boldText(text: shopSetting, size: 16.0, color: white),
          actions: [
            controller.isLoading.value
                ? loadingCupertino(circleColor: white)
                : TextButton.icon(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                          shopName: controller.shopNameController.text,
                          shopAddress: controller.shopAddressController.text,
                          shopMobile: controller.shopMobileController.text,
                          shopDesc: controller.shopDescController.text);
                    },
                    icon: const Icon(Icons.save_rounded, color: white,),
                    label: "SAVE".text.white.make(),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              20.heightBox,
              customTextField(
                label: name,
                hint: nameHint,
                controller: controller.shopNameController,
              ),
              10.heightBox,
              customTextField(
                label: address,
                hint: shopAddressHint,
                controller: controller.shopAddressController,
              ),
              10.heightBox,
              customTextField(
                label: telepon,
                hint: shopMobileHint,
                controller: controller.shopMobileController,
              ),
              10.heightBox,
              customTextField(
                label: description,
                hint: description,
                isDesc: true,
                controller: controller.shopDescController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
