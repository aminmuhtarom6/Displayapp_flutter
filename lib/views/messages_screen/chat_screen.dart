import 'package:display_app_flutter/const/const.dart';
import 'package:display_app_flutter/views/messages_screen/chat_buble.dart';
import 'package:display_app_flutter/widget/normal_text.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Vx.randomPrimaryColor,
        title: boldText(text: "Username", color: white, size: 16.0),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return chatBubble();
                  },
            )),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "enter message...",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: purpleColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: lightPurpleColor))),
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send_rounded,
                        color: purpleColor,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
