import 'package:flutter/cupertino.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/orders_controller.dart';
import 'package:display_app_flutter/views/orderScreen/orderplacedetail.dart';
import 'package:display_app_flutter/views/orderScreen/orderstatus.dart';
import 'package:display_app_flutter/widget/button_widget.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

//Vid seller backend no.3 menit 20

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: purpleColor,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: white,
                )),
            title: boldText(text: "Order Details", size: 16.0, color: white),
          ),
          bottomNavigationBar: Visibility(
            visible: !controller.confirmed.value,
            child: SizedBox(
              height: 60,
              width: context.screenWidth,
              child: buttonWidget(
                  color: green,
                  onPress: () {
                    controller.confirmed(true);
                    controller.changeStatus(
                        title: 'order_confirmed',
                        status: true,
                        docID: widget.data.id);
                  },
                  title: "Confirm Order"),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boldText(text: "Confirmed", size: 16.0, color: fontGrey),
                      CupertinoSwitch(
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value =value;
                          controller.changeStatus(
                              title: 'order_confirmed',
                              status: true,
                              docID: widget.data.id);
                        },
                        activeColor: lightPurpleColor,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      orderStatus(
                          color: red,
                          icon: Icons.done,
                          title: "Placed",
                          showDone: widget.data['order_placed']),
                      orderStatus(
                          color: Colors.blue,
                          icon: Icons.thumb_up,
                          title: "Confirmed",
                          showDone: widget.data['order_confirmed']),
                      orderStatus(
                          color: golden,
                          icon: Icons.car_crash,
                          title: "On Delivery",
                          showDone: widget.data['order_on_delivery']),
                      orderStatus(
                          color: Colors.purple,
                          icon: Icons.done_all_rounded,
                          title: "Delivered",
                          showDone: widget.data['order_delivered']),
                      const Divider(),
                      10.heightBox,
                      orderPlaceDetails(
                          d1: "${widget.data['order_code']}"
                              .text
                              .make(),
                          d2: "${widget.data['shipping_method']}",
                          title1: "Order Code",
                          title2: "Shipping Method"),
                      orderPlaceDetails(
                          d1: intl.DateFormat()
                              .add_yMMMMd()
                              .format(widget.data['order_time'].toDate()),
                          d2: "${widget.data['payment_method']}",
                          title1: "Order date",
                          title2: "Payment Method"),
                      orderPlaceDetails(
                          d1: "Unpaid",
                          d2: "Order Placed",
                          title1: "Payment Status",
                          title2: "Delivery Status"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address".text.bold.make(),
                                "${widget.data['order_recipient']}".text.make(),
                                "${widget.data['order_by_address']}"
                                    .text
                                    .make(),
                                "${widget.data['order_by_city']}".text.make(),
                                "${widget.data['order_by_state']}".text.make(),
                                "${widget.data['order_by_postalcode']}"
                                    .text
                                    .make(),
                                "${widget.data['order_by_phone']}".text.make(),
                              ],
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  40.widthBox,
                                  "Total Amount".text.make(),
                                  "${widget.data['total_amount']}"
                                      .numCurrency
                                      .text
                                      .bold
                                      .size(14)
                                      .color(red)
                                      .make(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ).box.shadowMd.rounded.white.make(),
                  10.heightBox,
                  boldText(
                      text: "Ordered Products", color: fontGrey, size: 18.0),
                  10.heightBox,
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(controller.orders.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          5.heightBox,
                          orderPlaceDetails(
                              title1: "${controller.orders[index]['title']}",
                              title2: "${controller.orders[index]['tprice']}"
                                  .numCurrency,
                              d1: "${controller.orders[index]['qty']}x",
                              d2: "Refundable"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: lightGrey,
                              child: "${controller.orders[index]['variant']}"
                                  .text
                                  .gray900
                                  .makeCentered(),
                            ),
                          ),
                          10.heightBox,
                        ],
                      );
                    }).toList(),
                  )
                      .box
                      .shadowMd
                      .rounded
                      .white
                      .margin(const EdgeInsets.only(bottom: 4))
                      .make(),
                ],
              ),
            ),
          )),
    );
  }
}
