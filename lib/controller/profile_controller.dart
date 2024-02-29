// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var profileImagePath = ''.obs;

  var profileImageLink = '';

  var isLoading = false.obs;

  //text field
  var namaController = TextEditingController();
  var passController = TextEditingController();
  var newpassController = TextEditingController();

  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopDescController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImge() async {
    var filename = basename(profileImagePath.value);
    var destintion = 'image/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destintion);
    await ref.putFile(File(profileImagePath.value));

    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(sellersCollection).doc(currentUser!.uid);
    await store.set(
      {'seller_name': name, 'password': password, 'imageUrl': imgUrl},
      SetOptions(merge: true),
    );

    isLoading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {});
  }

  updateShop({shopName, shopAddress, shopMobile, shopDesc}) async {
    var store = firestore.collection(sellersCollection).doc(currentUser!.uid);
    await store.set({
      'seller_name': shopName,
      'shop_address': shopAddress,
      'shop_mobil': shopMobile,
      'shop_desc': shopDesc,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  
}
