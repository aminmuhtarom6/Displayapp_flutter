// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/productScreen/add_product.dart';
import 'package:display_app_flutter/views/productScreen/edit_product.dart';
import 'package:display_app_flutter/views/productScreen/editproduct_screen.dart';
import 'package:display_app_flutter/views/productScreen/product_details.dart';
import 'package:display_app_flutter/widget/appbar_widget.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          child: const Icon(
            Icons.add,
            color: white,
          ),
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            controller.resetController();
            Get.to(() => const AddProducts());
          }),
      appBar: appbarWidget("All Products"),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingCupertino());
            } else if (snapshot.data!.docs.isEmpty) {
              return "No product".text.color(lightPurpleColor).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              data.length,
                              (index) => Card(
                                    child: ListTile(
                                      leading: Image.network(
                                        data[index]['p_imgs'][0],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      title: boldText(
                                          text: "${data[index]['p_name']}",
                                          color: darkGrey),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          normalText(
                                              text: "${data[index]['p_price']}"
                                                  .numCurrency,
                                              color: darkGrey),
                                          boldText(
                                              text: data[index]
                                                          ['is_featured'] ==
                                                      true
                                                  ? "Featured"
                                                  : "",
                                              color: red),
                                        ],
                                      ),
                                      trailing: VxPopupMenu(
                                          showArrow: false,
                                          menuBuilder: () => Column(
                                                  children: List.generate(
                                                      popUpMenuTitles.length,
                                                      (i) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                10.widthBox,
                                                                Icon(
                                                                  popUpMenuIcons[
                                                                      i],
                                                                  color: data[index]['featured_id'] ==
                                                                              currentUser!.uid &&
                                                                          i == 0
                                                                      ? green
                                                                      : lightPurpleColor,
                                                                ),
                                                                10.widthBox,
                                                                normalText(
                                                                    text: data[index]['featured_id'] == currentUser!.uid &&
                                                                            i ==
                                                                                0
                                                                        ? 'Remove Featured'
                                                                        : popUpMenuTitles[
                                                                            i],
                                                                    color:
                                                                        darkGrey)
                                                              ],
                                                            ).onTap(() {
                                                              switch (i) {
                                                                case 0:
                                                                  if (data[index]
                                                                          [
                                                                          'is_featured'] ==
                                                                      true) {
                                                                    controller.removeFeatured(
                                                                        data[index]
                                                                            .id);
                                                                    VxToast.show(
                                                                        context,
                                                                        msg:
                                                                            "Removed");
                                                                  } else {
                                                                    controller.addFeatured(
                                                                        data[index]
                                                                            .id);
                                                                    VxToast.show(
                                                                        context,
                                                                        msg:
                                                                            "Added");
                                                                  }
                                                                  break;
                                                                case 1:
                                                                  Get.to(() =>
                                                                      EditProductScreen(
                                                                        // name: controller.snapshotData['p_name'],
                                                                        // desc: controller.snapshotData['p_description'],
                                                                        // price: controller.snapshotData['p_price'],
                                                                        // qty: controller.snapshotData['p_qty'],
                                                                        data: data[
                                                                            index],
                                                                      ));
                                                                  controller
                                                                      .getCategories();
                                                                  controller
                                                                      .populateCategoryList();
                                                                  controller
                                                                      .resetController();
                                                                  break;
                                                                case 2:
                                                                  controller.removeProduct(
                                                                      data[index]
                                                                          .id);
                                                                  VxToast.show(
                                                                      context,
                                                                      msg:
                                                                          "Product Removed");
                                                                  break;
                                                                default:
                                                              }
                                                            }),
                                                          )))
                                              .box
                                              .white
                                              .rounded
                                              .width(200)
                                              .make(),
                                          clickType: VxClickType.singleClick,
                                          child: const Icon(
                                              Icons.more_vert_rounded)),
                                      onTap: () {
                                        Get.to(() => ProductDetails(
                                          title: data[index]['p_name'],
                                              data: data[index],
                                            ));
                                      },
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ));
            }
          }),
    );
  }
}
