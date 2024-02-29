import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isLoading = false.obs;
  
  //text controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethode({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
    
  }

  // signUp methode
  Future<UserCredential?> signupMethode({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data methode
  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(sellersCollection).doc(currentUser!.uid);
    store.set({
      'sellers_name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'product_count' : "0",
      'wishlist_count' : "0"
    });
  }

  //signout methode
  signoutMethode(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
