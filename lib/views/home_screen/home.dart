import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/home_controller.dart';
import 'package:display_app_flutter/views/home_screen/home_screen.dart';
import 'package:display_app_flutter/views/productScreen/product_display_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductsDisplay(),
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: "Dashboard"),
      const BottomNavigationBarItem(icon: Icon(CupertinoIcons.cube_box_fill), label: "Products"),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: lightPurpleColor,
            unselectedItemColor: purpleColor,
            items: bottomNavbar),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
