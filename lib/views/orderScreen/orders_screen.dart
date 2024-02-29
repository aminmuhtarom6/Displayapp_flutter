import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/orders_controller.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/orderScreen/order_details.dart';
import 'package:display_app_flutter/widget/appbar_widget.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingCupertino());
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Orders".text.color(lightPurpleColor).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(data.length, (index) {
                          var time = data[index]['order_time'];
                          return ListTile(
                            leading: Image.asset(
                              imgProduct,
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            tileColor: textfieldGrey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: boldText(
                                text: "${data[index]['order_code']}",
                                color: lightPurpleColor),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_month_rounded,
                                      color: fontGrey,
                                    ),
                                    10.widthBox,
                                    normalText(
                                        text: intl.DateFormat()
                                            .add_yMMMMd()
                                            .format(time.toDate()),
                                        color: purpleColor),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.payment_rounded,
                                      color: fontGrey,
                                    ),
                                    10.widthBox,
                                    Row(
                                      children: [
                                        normalText(text: "Rp", color: red),
                                        normalText(text: "${data[index]['total_amount']}".numCurrency, color: red),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            onTap: () {
                              Get.to(() =>  OrderDetails(data: data[index],));
                            },
                          ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                        }),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         ListView(
      //           physics: const BouncingScrollPhysics(),
      //           shrinkWrap: true,
      //           children: List.generate(
      //               20,
      //               (index) => ListTile(
      //                     leading: Image.asset(
      //                       imgProduct,
      //                       width: 100,
      //                       height: 100,
      //                       fit: BoxFit.contain,
      //                     ),
      //                     tileColor: textfieldGrey,
      //                     shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(12)),
      //                     title: boldText(
      //                         text: "Product Title", color: lightPurpleColor),
      //                     subtitle: Column(
      //                       children: [
      //                         Row(
      //                           children: [
      //                             const Icon(Icons.calendar_month_rounded, color: fontGrey,),
      //                             10.widthBox,
      //                             normalText(
      //                                 text: intl.DateFormat()
      //                                     .add_yMMMMd()
      //                                     .format(DateTime.now()),
      //                                 color: purpleColor),
      //                           ],
      //                         ),
      //                         Row(
      //                           children: [
      //                             const Icon(Icons.payment_rounded, color: fontGrey,),
      //                             10.widthBox,
      //                             normalText(
      //                                 text: "Rp400000000",
      //                                 color: red),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                     onTap: () {
      //                       Get.to(()=> const OrderDetails());
      //                     },
      //                   ).box.margin(const EdgeInsets.only(bottom: 4)).make()),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
