import 'dart:io';

import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/profile_controller.dart';
import 'package:display_app_flutter/widget/custom_textfield.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.namaController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: white,
          ).onTap(() {
            Get.back();
          }),
          title: boldText(text: editAccount, size: 18.0, color: white),
          actions: [
            controller.isLoading.value
                ? loadingCupertino()
                : TextButton.icon(
                    icon: const Icon(
                      Icons.save_rounded,
                      color: white,
                    ),
                    label: "SAVE".text.white.make(),
                    onPressed: () async {
                      controller.isLoading(true);
                      //if image is not selected
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImge();
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Image Changed");
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Image Not Changed");
                      }
                      //if old pass matches data base
                      if (controller.snapshotData['password'] ==
                          controller.passController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.passController.text,
                            newpassword: controller.newpassController.text);
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.namaController.text,
                            password: controller.newpassController.text);
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Wrong password");
                      } else if (controller.passController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.namaController.text,
                            password: controller.snapshotData['password']);
                      } else {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Wrong password");
                        controller.isLoading(false);
                      }
                    },
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child:  Column(
              children: [
                //if data image url and controller path is empty
                controller.snapshotData['imageUrl'] == '' &&
                        controller.profileImagePath.isEmpty
                    ? const Icon(
                        Icons.person_4_rounded,
                        size: 100,
                        fill: 1.0,
                        color: white,
                      )
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .shadowOutline(outlineColor: lightPurpleColor)
                        .make()
    
                    //if data is not empty but controller path is empty
                    : controller.snapshotData['imageUrl'] != '' &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(
                            controller.snapshotData['imageUrl'],
                            width: 150,
                            fit: BoxFit.cover,
                          )
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .shadowOutline(outlineColor: white)
                            .make()
    
                        //else if controller is not empty
                        : Image.file(
                            File(controller.profileImagePath.value),
                            width: 150,
                            fit: BoxFit.cover,
                          )
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .shadowOutline(outlineColor: white)
                            .make(),
                20.heightBox,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: white, shadowColor: lightPurpleColor),
                    onPressed: () {
                      controller.changeImage(context);
                    },
                    child: boldText(text: "Change Image", color: purpleColor)),
                15.heightBox,
                const Divider(
                  color: Vx.purple800,
                ),
                10.heightBox,
                customTextField(
                    label: controller.snapshotData['seller_name'],
                    hint: nameHint,
                    controller: controller.namaController),
                10.heightBox,
                boldText(text: "Change Password", color: white),
                15.heightBox,
                customTextField(
                    obscureText: true,
                    label: password,
                    hint: passwordHint,
                    controller: controller.passController),
                15.heightBox,
                customTextField(
                    obscureText: true,
                    label: confirmPass,
                    hint: passwordHint,
                    controller: controller.newpassController),
              ],
          ),
        ),
      ),
    );
  }
}
