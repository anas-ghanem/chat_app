import 'package:chat_app/conset.dart';
import 'package:chat_app/massage_model.dart';
import 'package:chat_app/widgets.dart/chat_buble.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  String id = "chat_page";
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference messages = FirebaseFirestore.instance.collection(
    "messages",
  );
  TextEditingController messageController = TextEditingController();
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(korder, descending: true).snapshots(),
      builder: (context, Snapshot) {
        if (Snapshot.hasData) {
          List<Massage> messages_list = [];
          for (int i = 0; i < Snapshot.data!.docs.length; i++) {
            messages_list.add(Massage.fromJson(Snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("messages"),
              backgroundColor: kprimarykey,
              centerTitle: true,
              foregroundColor: Colors.white,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: messages_list.length,
                    itemBuilder: (context, index) {
                      return messages_list[index].id == email
                          ? chat_buble(massage: messages_list[index])
                          : chat_bubleforfrinds(massage: messages_list[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (value) {
                      messages.add({
                        "text": value,
                        "createdat": DateTime.now(),
                        "id": email,
                      });
                      messageController.clear();
                      controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.send, color: kprimarykey),
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: kprimarykey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
