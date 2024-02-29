import 'package:display_app_flutter/const/const.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {


@override
  void onInit() {
    getSellername();
    super.onInit();
  }
  var navIndex = 0.obs;
  var username = '' ;

  getSellername() async {
     var n = await firestore
        .collection(sellersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['seller_name'];
      }
    });
    username = n;
  }
}
