import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils.dart';
import 'package:tech_media/view%20models/services/session_manager.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import '../../../res/color.dart';

class MessageScreen extends StatefulWidget {
  final String name, image, receiverId;

  const MessageScreen(
      {Key? key,
      required this.image,
      required this.receiverId,
      required this.name})
      : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref('Chat');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),

        automaticallyImplyLeading: true,
      foregroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
        backgroundColor: AppColors.mainAppColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: FirebaseAnimatedList(
                    query: ref,
                    itemBuilder: (context, snapshot, animation, index) {
                      if (widget.receiverId ==
                          snapshot.child('receiver').value.toString()) {
                        if(SessionController().userId.toString() == snapshot.child('sender').value.toString()){
                          return ListTile(
                            title: BubbleSpecialThree(
                              text:
                              snapshot.child('message').value.toString(),
                              color: AppColors.mainAppColor,
                              tail: false,

                              textStyle: TextStyle(
                                color: Colors.white,

                              ),

                            ),
                          );
                        }else{
                          return ListTile(
                            title: BubbleSpecialThree(
                              text:
                              snapshot.child('message').value.toString(),
                              color: AppColors.grayColor,
                              tail: false,
                              isSender: false,
                              textStyle: TextStyle(
                                color: Colors.black,

                              ),

                            ),
                          );
                        }

                      } else {
                        return Container();
                      }
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: messageController,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            height: 0,
                            fontSize: 16,
                          ),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                sendMessage();
                              },
                              icon: Icon(Icons.send)),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldDefaultFocus),
                              borderRadius: BorderRadius.circular(50)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.mainAppColor),
                              borderRadius: BorderRadius.circular(50)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: AppColors.alertColor),
                              borderRadius: BorderRadius.circular(50)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldDefaultBorderColor),
                              borderRadius: BorderRadius.circular(50)),
                          hintText: "Enter Message",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  height: 0,
                                  color: AppColors.primaryTextTextColor
                                      .withOpacity(0.8))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage("Enter Message", Colors.red);
    } else {
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiver': widget.receiverId,
        'type': 'text',
        'time': timeStamp.toString()
      }).then((value) {
        messageController.clear();
      });
    }
  }
}
