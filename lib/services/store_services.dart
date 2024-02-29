import 'package:display_app_flutter/const/const.dart';

class StoreServices{

  static getProfile(uid){
    return firestore.collection(sellersCollection).where("id", isEqualTo: uid).get();
  }

  static getMessages(uid){
    return firestore.collection(chatsCollection).where("id", isEqualTo: uid).snapshots();
  }

  static getOrders(uid){
    return firestore.collection(ordersCollection).where("vendors", arrayContains: uid).snapshots();
  }

  static getProducts(uid){
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).snapshots();
  }

  static getFeaturedProducts(uid){
    return firestore.collection(productsCollection).where('vendor_id', isEqualTo: uid).orderBy('p_whishlist'.length).snapshots();
  }

  static getAllProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  static searchProduct(title){
    return firestore.collection(productsCollection).where('p_name', isLessThanOrEqualTo: title).get();
  }

  static getUser(uid) {
    return firestore
        .collection(sellersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

    static getCounts() async {
    var res = Future.wait([
      firestore
          .collection(productsCollection)
          .where('p_category', isEqualTo: 'Velgs')
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_category', isEqualTo: 'Tires')
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }



}