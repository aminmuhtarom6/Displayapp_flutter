import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/productScreen/product_details.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: purpleColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: white,
            )),
        title: title!.text.color(white).fontWeight(FontWeight.w700).make(),
      ),
      body: FutureBuilder(
        future: StoreServices.searchProduct(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingCupertino(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Not Found".text.color(purpleColor).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) =>
                    element['p_name'].toString().toLowerCase().contains(title!))
                .toList();
            return GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    mainAxisExtent: 300),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              filtered[index]['p_imgs'][0],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ).box.rounded.make(),
                            10.heightBox,
                            "${filtered[index]['p_name']}"
                                .text
                                .bold
                                .size(13)
                                .color(fontGrey)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['p_price']}"
                                .numCurrency
                                .text
                                .color(lightPurpleColor)
                                .fontWeight(FontWeight.w700)
                                .size(16)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .margin(const EdgeInsets.all(4))
                            .roundedSM
                            .shadowMd
                            .padding(const EdgeInsets.all(8))
                            .make()
                            .onTap(() {
                          Get.to(() => ProductDetails(
                            title: "${filtered[index]['p_name']}",
                                data: filtered[index],
                              ));
                        }))
                    .toList());
          }
        },
      ),
    );
  }
}
