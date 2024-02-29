import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ProductDetails({Key? key,required this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: boldText(text: "${data['p_name']}", size: 16.0, color: white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                  height: 300,
                  autoPlay: true,
                  itemCount: data['p_imgs'].length,
                  viewportFraction: 1.0,
                  itemBuilder: (context, index) {
                    return Image.network(
                      data['p_imgs'][index],
                      width: double.infinity,
                      fit: BoxFit.contain,
                    );
                  }),
              10.heightBox,
              boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
              5.heightBox,
              //rating
              VxRating(
                isSelectable: false,
                value: double.parse(data['p_rating']),
                onRatingUpdate: (value) {},
                normalColor: textfieldGrey,
                selectionColor: golden,
                count: 5,
                size: 25,
                maxRating: 5,
              ),
              5.heightBox,
              Row(
                children: [
                  boldText(text: "Rp", color: red, size: 16.0),
                  boldText(text: "${data['p_price']}".numCurrency, color: red, size: 16.0),
                ],
              ),5.heightBox,
              Row(
                children: [
                  boldText(text: "${data['p_category']}", color: fontGrey, size: 16.0),
                  10.widthBox,
                  normalText(text: "${data['p_subcategory']}", color: red, size: 16.0),
                ],
              ),
              10.heightBox,
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Variant".text.color(fontGrey).make(),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              padding: const EdgeInsets.all(4),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    data['p_variant'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox(
                                                    child: Text(
                                                        data['p_variant'][index]))
                                                .white
                                                .size(75, 40)
                                                .roundedLg
                                                .alignCenter
                                                .shadowSm
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(() {}),
                                            Visibility(
                                                child: const SizedBox(
                                              height: 40,
                                              width: 75,
                                            )
                                                    .box
                                                    .roundedLg
                                                    .alignCenter
                                                    .color(
                                                        lightPurpleColor.withOpacity(0.20))
                                                    .size(75, 40)
                                                    .make())
                                          ],
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Quantity".text.color(fontGrey).make(),
                      ),
                      Row(children: [
                        10.heightBox,
                        "( ${data['p_qty']} available )".text.color(fontGrey).make(),
                        30.heightBox,
                      ]),
                      
                    ],
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .shadowMd
                  .padding(const EdgeInsets.all(10))
                  .make(),
              10.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "Deskripsi Produk", color: fontGrey, size: 16.0),
                  10.heightBox,
                  normalText(
                      text: "${data['p_description']}",
                      color: fontGrey,
                      size: 14.0),
                ],
              ).box.white.rounded.shadowMax.size(context.screenWidth-10, 160).padding(const EdgeInsets.all(10)).make()
            ],
          ),
        ),
      ),
    );
  }
}
