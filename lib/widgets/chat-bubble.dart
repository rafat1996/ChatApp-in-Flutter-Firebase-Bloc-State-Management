import 'package:chatapp/constants/color.dart';
import 'package:chatapp/models/message-model.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: kSecoundColor),
        child: Text(
          message.message,
          style: TextStyle(color: kTextColor),
        ),
      ),
    );
  }
}

class ChatBubbleAnother extends StatelessWidget {
  const ChatBubbleAnother({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: kSecoundAnotherColor),
        child: Text(
          message.message,
          style: TextStyle(color: kTextColor),
        ),
      ),
    );
  }
}
