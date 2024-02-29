import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/home_screen/search_screen.dart';
import 'package:display_app_flutter/views/productScreen/product_details.dart';
import 'package:display_app_flutter/widget/appbar_widget.dart';
import 'package:display_app_flutter/widget/dashboard_button.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: Container(
        color: lightGrey,
        child: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingCupertino());
              } else {
                var data = snapshot.data!.docs;
                data = data.sortedBy((a, b) =>
                    b['featured_id'].length.compareTo(a['featured_id'].length));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                    width: 10.0,
                                    color: lightPurpleColor,
                                    style: BorderStyle.solid)),
                            suffixIcon:
                                const Icon(CupertinoIcons.search).onTap(() {
                              if (controller
                                  .searchController.text.isNotEmptyAndNotNull) {
                                Get.to(() => SearchScreen(
                                      title: controller.searchController.text,
                                    ));
                              }
                            }),
                            filled: true,
                            fillColor: white,
                            hintText: "search Anything",
                            hintStyle: const TextStyle(color: textfieldGrey)),
                      ).box.roundedLg.make(),
                      20.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     dashboardButton(context,
                      //         title: "Velgs",
                      //         count: "${data.length}",
                      //         icon: imgVelg),
                      //     dashboardButton(context,
                      //         title: "Tires",
                      //         count: "${data.length}",
                      //         icon: imgTire),
                      //   ],
                      // ),
                      FutureBuilder(
                          future: StoreServices.getCounts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: loadingIndicator(),
                              );
                            } else {
                              var countData = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      dashboardButton(context,
                                          title: "Velgs",
                                          count: countData[0].toString(),
                                          icon: imgVelg),
                                      40.widthBox,
                                      dashboardButton(context,
                                          title: "Tires",
                                          count: countData[1].toString(),
                                          icon: imgTire),
                                    ],
                                  ),
                                ],
                              );
                            }
                          }),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      boldText(
                          text: "Featured Product",
                          color: purpleColor,
                          size: 16.0),
                      20.heightBox,
                      // Center(child: Lottie.asset('assets/lottie.json' ).box.size(400, 400).make()),
                      20.heightBox,
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            data.length,
                            (index) => data[index]['featured_id'].length == 0
                                ? const SizedBox()
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                          subtitle: normalText(
                                              text: "${data[index]['p_price']}"
                                                  .numCurrency,
                                              color: darkGrey),
                                          onTap: () {
                                            Get.to(() => ProductDetails(
                                              title: data[index]['p_name'],
                                                data: data[index]));
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                    .box
                                    .color(lightGrey)
                                    .shadowLg
                                    .margin(const EdgeInsets.all(4))
                                    .rounded
                                    .width(140)
                                    .make(),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           dashboardButton(context,
      //               title: products, count: "60", icon: icProducts),
      //           dashboardButton(context,
      //               title: orders, count: "15", icon: icOrders),
      //         ],
      //       ),
      //       20.heightBox,
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           dashboardButton(context,
      //               title: rating, count: "60", icon: icStar),
      //           dashboardButton(context,
      //               title: orders, count: "20", icon: icOrders),
      //         ],
      //       ),
      //       10.heightBox,
      //       const Divider(),
      //       10.heightBox,
      //       boldText(text: popular, color: purpleColor, size: 16.0),
      //       20.heightBox,
      //       Expanded(
      //         child: ListView(
      //           physics: const BouncingScrollPhysics(),
      //           shrinkWrap: true,
      //           children: List.generate(
      //             3,
      //             (index) => Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: ListTile(
      //                     leading: Image.asset(
      //                       imgProduct,
      //                       width: 100,
      //                       height: 100,
      //                       fit: BoxFit.contain,
      //                     ),
      //                     title: boldText(text: "Product Title", color: darkGrey),
      //                     subtitle: normalText(text: "Rp40000000", color: darkGrey),
      //                     onTap: () {Get.to(() => const ProductDetails());},
      //                   ),
      //                 ),
      //               ],
      //             ).box.color(lightGrey).shadowLg.margin(const EdgeInsets.all(4)).rounded.width(140).make(),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
