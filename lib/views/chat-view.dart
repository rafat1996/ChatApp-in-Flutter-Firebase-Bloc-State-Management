import 'package:chatapp/constants/color.dart';
import 'package:chatapp/constants/firestore-colliction.dart';
import 'package:chatapp/models/message-model.dart';
import 'package:chatapp/widgets/chat-bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    
    var email = ModalRoute.of(context)!.settings.arguments;
    CollectionReference messages =
        FirebaseFirestore.instance.collection(kCollictionMessages);
    TextEditingController controller = TextEditingController();
    final _controllerScroll = ScrollController();
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreateAt, descending: false).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageModelList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageModelList
                  .add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, '/');
                        },
                        icon: const Icon(Icons.exit_to_app_sharp,color: Colors.black,))
                  ],
                  backgroundColor: kSecoundColor,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'Chat App',
                    style: TextStyle(fontFamily: 'Pacifico'),
                  ),
                  centerTitle: true,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: _controllerScroll,
                          itemCount: messageModelList.length,
                          itemBuilder: (context, index) {
                            return messageModelList[index].id == email
                                ? ChatBubble(
                                    message: messageModelList[index],
                                  )
                                : ChatBubbleAnother(
                                    message: messageModelList[index]);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 5),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          messages.add({
                            kMessage: data,
                            kCreateAt: DateTime.now(),
                            'id': email
                          });
                          controller.clear();
                          _controllerScroll.animateTo(
                              _controllerScroll.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Your Message',
                           
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: kSecoundColor, width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: kSecoundColor, width: 2),
                            )),
                      ),
                    ),
                  ],
                ));
          } else {
            return const Text('Loading');
          }
        });
  }
}
