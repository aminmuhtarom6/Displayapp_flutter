// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/auth_controller.dart';
import 'package:display_app_flutter/controller/profile_controller.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/home_screen/hidden_drawer.dart';
import 'package:display_app_flutter/views/home_screen/home.dart';
import 'package:display_app_flutter/views/home_screen/home_screen.dart';
import 'package:display_app_flutter/views/messages_screen/messages_screen.dart';
import 'package:display_app_flutter/views/productScreen/product_display_screen.dart';
import 'package:display_app_flutter/views/settingScreen/edit_profilescreen.dart';
import 'package:display_app_flutter/views/settingScreen/shop_settingscreen.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: setting, size: 18.0, color: white),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.person_crop_circle_badge_exclam,
              color: white,
            ),
            tooltip: "Edit",
            highlightColor: lightPurpleColor,
            onPressed: () {
              Get.to(() => EditProfileScreen(
                    username: controller.snapshotData['seller_name'],
                  ));
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.logout_rounded, color: white),
          //   tooltip: "logout",
          //   highlightColor: lightPurpleColor,
          //   onPressed: () async {
          //     await Get.find<AuthController>().signoutMethode(context);
          //     Get.offAll(() => const HiddenDrawer());
          //     // ignore: use_build_context_synchronously
          //     VxToast.show(context, msg: "Log Out Berhasil");
          //   },
          // ),
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingCupertino(circleColor: red));
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: controller.snapshotData['imageUrl'] == ''
                          ? const Icon(
                              Icons.person_4_rounded,
                              color: white,
                              size: 50,
                            )
                              .box
                              .size(100, 100)
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .shadowOutline(outlineColor: lightPurpleColor)
                              .make()
                          : Image.network(controller.snapshotData['imageUrl'],
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .shadowOutline(outlineColor: lightPurpleColor)
                              .make(),
                      title: boldText(
                          text: "${controller.snapshotData['seller_name']}",
                          size: 16.0,
                          color: white),
                      subtitle: normalText(
                          text: "${controller.snapshotData['email']}",
                          size: 14.0,
                          color: white),
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: List.generate(
                            settingIconList.length,
                            (index) => ListTile(
                                  splashColor: lightPurpleColor,
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const ShopSettings());
                                        break;
                                      case 1:
                                        Get.to(() => const MessagesScreen());
                                        break;
                                      default:
                                    }
                                  },
                                  leading: Icon(
                                    settingIconList[index],
                                    color: white,
                                  ),
                                  title: normalText(
                                      text: settingIconTitle[index],
                                      color: white),
                                )),
                      ),
                    ),
                    20.heightBox,
                    ElevatedButton.icon(
                        label:
                            "Display Mode".text.purple900.bold.size(18).make(),
                        onPressed: ()  {
                          Get.to(()=> const HiddenDrawer());
                        },
                        icon: const Icon(
                          CupertinoIcons.desktopcomputer,
                          color: purpleColor,
                        )).box.rounded.size(200, 50).make(),
                  ],
                ),
              );
            }
          }),
    );
  }
}
