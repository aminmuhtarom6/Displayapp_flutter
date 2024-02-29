import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/views/auth_screen/login_screen.dart';
import 'package:display_app_flutter/views/home_screen/home.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Home",
              baseStyle: const TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              selectedStyle: const TextStyle(
                  color: white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Home()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Login",
              baseStyle: const TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              selectedStyle: const TextStyle(
                  color: white, fontSize: 18, fontWeight: FontWeight.bold)),
          const LoginScreen()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Colors.deepPurple.shade300,
      initPositionSelected: 0,
      slidePercent: 50,
      verticalScalePercent: 90,
      contentCornerRadius: 25,
      withShadow: true,
      disableAppBarDefault: true,
    );
  }
}
