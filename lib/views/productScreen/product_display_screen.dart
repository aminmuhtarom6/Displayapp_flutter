import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/products_controller.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/productScreen/product_details.dart';
import 'package:display_app_flutter/widget/appbar_widget.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:get/get.dart';

class ProductsDisplay extends StatelessWidget {
  const ProductsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProductController());
    return Scaffold(
      appBar: appbarWidget("All Products"),
      body: Container(
        color: lightGrey,
        padding: const EdgeInsets.all(12),
        width: context.screenWidth,
        child: Column(
          children: [
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: StoreServices.getProducts(currentUser!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingCupertino());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return "No product"
                            .text
                            .color(lightPurpleColor)
                            .makeCentered();
                      } else {
                        var data = snapshot.data!.docs;
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            mainAxisExtent: 300),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            data[index]['p_imgs'][0],
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ).box.rounded.make(),
                                          10.heightBox,
                                          "${data[index]['p_name']}"
                                              .text
                                              .size(10.0)
                                              .bold
                                              .wrapWords(false)
                                              .color(fontGrey)
                                              .makeCentered(),
                                          10.heightBox,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: ["RP "
                                                  .text
                                                  .bold
                                                  .color(lightPurpleColor)
                                                  .size(14)
                                                  .make(),
                                              "${data[index]['p_price']}"
                                                  .numCurrency
                                                  .text
                                                  .bold
                                                  .color(lightPurpleColor)
                                                  .size(16)
                                                  .make(),
                                            ],
                                          ),
                                        ],
                                      )
                                          .box
                                          .white
                                          .shadowLg
                                          .margin(const EdgeInsets.all(4))
                                          .rounded
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(() {
                                        Get.to(() => ProductDetails(
                                          title: data[index]['p_name'],
                                          data: data[index],
                                        ));
                                      });
                          },
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
