import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/controller/auth_controller.dart';
import 'package:display_app_flutter/views/home_screen/home_admin.dart';
import 'package:display_app_flutter/widget/button_widget.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // normalText(text: welcome, size: 18.0, color: white),
                // 20.heightBox,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       logo,
                //       width: 60,
                //     )
                //         .box
                //         .border(color: white)
                //         .rounded
                //         .padding(const EdgeInsets.all(10))
                //         .makeCentered(),
                //     10.heightBox,
                //   ],
                // ),
                // 20.heightBox,
                // normalText(text: appname, size: 18.0, color: white),
                Lottie.asset('assets/fire.json' ).box.rounded.size(400, 360).makeCentered(),
                // const Divider(),
                10.heightBox,
                Obx(
                  ()=> Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      normalText(text: email, size: 16.0, color: white),
                      10.heightBox,
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: emailHint,
                        ),
                      )
                          .box
                          .white
                          .rounded
                          .shadowMd
                          .padding(const EdgeInsets.all(4))
                          .make(),
                      20.heightBox,
                      normalText(text: password, size: 16.0, color: white),
                      10.heightBox,
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: passwordHint,
                        ),
                      )
                          .box
                          .white
                          .rounded
                          .shadowMd
                          .padding(const EdgeInsets.all(4))
                          .make(),
                      5.heightBox,
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //       onPressed: () {},
                      //       child: normalText(
                      //         text: forgotPassword,
                      //         color: white,
                      //       )),
                      // ),
                      // 5.heightBox,
                      20.heightBox,
                      SizedBox(
                          width: context.screenWidth,
                          child: controller.isLoading.value ? loadingCupertino(circleColor: white) : buttonWidget(
                            title: login,
                            color: lightPurpleColor,
                            textColor: white,
                            onPress: () async {
                              controller.isLoading(true);
                                  await controller
                                      .loginMethode(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "logged in");
                                      controller.isLoading(false);
                                      Get.to(() => const HomeAdmin());
                                      controller.emailController.clear();
                                      controller.passwordController.clear();
                                    }else{
                                      controller.isLoading(false);
                                    }
                                  });
                            },
                          ))
                    ],
                  ),
                ),
                // 20.heightBox,
                // const Divider(),
                // Center(
                //   child: normalText(
                //     text: dontHaveAccount,
                //     color: white,
                //   ),
                // ),
                // 10.heightBox,
                // SizedBox(
                //     width: context.screenWidth,
                //     child: buttonWidget(
                //       title: signup,
                //       color: white,
                //       textColor: purpleColor,
                //       onPress: () {
                //         Get.to(() => const Home());
                //       },
                //     )),
                const Spacer(),
                Center(
                  child: boldText(text: credit, color: lightGrey),
                ),
                40.heightBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
