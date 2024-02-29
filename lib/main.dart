// ignore_for_file: unused_import

import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/views/auth_screen/login_screen.dart';
import 'package:display_app_flutter/views/home_screen/hidden_drawer.dart';
import 'package:display_app_flutter/views/home_screen/home.dart';
import 'package:display_app_flutter/views/home_screen/home_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  var isLoggedin = false;

  checkUser()async{
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted){
        isLoggedin = false;
      }else{
        isLoggedin = true;
      }
      setState(() {
        
      });
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Display App',
      theme: ThemeData(
        fontFamily: "SFPro",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 0.0,
        ),
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedin?  const HiddenDrawer() :const LoginScreen(),
     
    );
  }
}