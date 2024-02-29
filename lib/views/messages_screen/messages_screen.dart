import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/services/store_services.dart';
import 'package:display_app_flutter/views/messages_screen/chat_screen.dart';
import 'package:display_app_flutter/widget/loadingindicator.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          backgroundColor: lightPurpleColor,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: white,
              )),
          title: boldText(text: chat, size: 16.0, color: white),
        ),
        body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingCupertino(circleColor: purpleColor));
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Messages".text.color(lightPurpleColor).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                        data.length,
                        (index) {
                          var t =data[index]['created_on'] == null ? DateTime.now(): data[index]['created_on'].toDate();
                          var time = intl.DateFormat("h:mma").format(t);
                          return ListTile(
                              onTap: () {
                                Get.to(() => const ChatScreen());
                              },
                              leading: const CircleAvatar(
                                backgroundColor: golden,
                                child: Icon(
                                  Icons.person_4_rounded,
                                  color: white,
                                ),
                              ),
                              title: boldText(
                                  text: "${data[index]['sender_name']}",
                                  color: fontGrey,
                                  size: 16.0),
                              subtitle: normalText(
                                  text: "${data[index]['last_msg']}",
                                  color: fontGrey,
                                  size: 14.0),
                              trailing: normalText(
                                  text: time,
                                  color: fontGrey,
                                  size: 14.0),
                            );
                        } ),
                  ),
                ),
              );
            }
          },
          // body: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SingleChildScrollView(
          //     physics: const BouncingScrollPhysics(),
          //     child: Column(
          //       children: List.generate(20, (index) =>  ListTile(
          //         onTap: (){
          //           Get.to(()=> const ChatScreen());
          //         },
          //         leading: const CircleAvatar(
          //           backgroundColor: golden,
          //           child: Icon(Icons.person_4_rounded,color: white,),
          //         ),
          //         title: boldText(text: "Username", color: fontGrey, size: 16.0),
          //         subtitle: normalText(text: "last messege", color: fontGrey, size: 14.0),
          //         trailing: normalText(text: "10.00 AM", color: fontGrey, size: 14.0),
          //       )),
          //     ),
          //   ),
          // ),
        ));
  }
}
