import 'package:chat_app/conset.dart';
import 'package:chat_app/massage_model.dart';
import 'package:chat_app/widgets.dart/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String id = 'chat_page';
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    'messages',
  );
  final TextEditingController messageController = TextEditingController();
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final dynamic email = ModalRoute.of(context)?.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(korder, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final messagesList =
            snapshot.data!.docs.map((doc) => Massage.fromJson(doc)).toList();

        return Scaffold(
          backgroundColor: kbackground,
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Scholar Chat'),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: controller,
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    final message = messagesList[index];
                    return message.id == email
                        ? chat_bubleforfrinds(massage: message)
                        : chat_buble(massage: message);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالة...',
                          hintStyle: const TextStyle(color: Color(0xff7D8BA1)),
                          filled: true,
                          fillColor: const Color(0xffF3F6FA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isEmpty) return;
                          messages.add({
                            'text': value.trim(),
                            'createdat': DateTime.now(),
                            'id': email,
                          });
                          messageController.clear();
                          controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      color: kprimarykey,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          if (messageController.text.trim().isEmpty) return;
                          messages.add({
                            'text': messageController.text.trim(),
                            'createdat': DateTime.now(),
                            'id': email,
                          });
                          messageController.clear();
                          controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(14),
                          child: Icon(Icons.send_rounded, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
