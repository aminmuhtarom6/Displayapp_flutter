import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/controller/home_controller.dart';
import 'package:display_app_flutter/controller/variant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/models/category_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {

  late QueryDocumentSnapshot snapshotData;
 
  var isLoading = false.obs;

  var searchController = TextEditingController();

  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pqtyController = TextEditingController();
  var pVariantController = TextEditingController();

  var pCategoryList = <String>[].obs;
  var pSubCategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var pImagesListEdit = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;

  List<Variants> variants = [
    Variants(variant: "R14"),
    Variants(variant: "R15"),
    Variants(variant: "R16"),
    Variants(variant: "R17"),
    Variants(variant: "R18"),
    Variants(variant: "R19"),
    Variants(variant: "R20"),
  ];

  List<dynamic> selectedVariant =[];
  var selectVariantindex = ''.obs;

  get clear => null;

  getCategories() async {
    pCategoryList.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    pCategoryList.clear();

    for (var item in category) {
      pCategoryList.add(item.name);
    }
  }

  populateSubCategoryList(cat) {
    pSubCategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      pSubCategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImagesProducts() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destintion = 'image/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destintion);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_variant': FieldValue.arrayUnion([pVariantController.text]),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': pdescController.text,
      'p_name': pnameController.text.toUpperCase(),
      'p_price': ppriceController.text,
      'p_qty': pqtyController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': '',
    });
    isLoading(false);

    VxToast.show(context, msg: "Product added");
  }

  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'is_featured': true, 'featured_id': currentUser!.uid},
        SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'is_featured': false, 'featured_id': ''}, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }

  updateProduct(docId) async {
    var store = firestore.collection(productsCollection).doc(docId);

    await store.set({
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_variant': pVariantController.text,
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_description': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_qty': pqtyController.text,
    }, SetOptions(merge: true) );
    isLoading(false);
    resetController();
  }

  resetController(){
  pImagesLinks.clear();
  pnameController.clear();
  pdescController .clear();
  ppriceController.clear();
  pqtyController.clear();
  pVariantController.clear();
}

}
