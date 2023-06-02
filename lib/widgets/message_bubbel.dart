import 'dart:ffi';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.text,
      required this.isMe,
      required this.isSystemMsg});

  final String text;
  final bool isMe;
  final bool isSystemMsg;
  @override
  Widget build(BuildContext context) {
    print(isSystemMsg);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isSystemMsg
            ? CrossAxisAlignment.center
            : isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Material(
            borderRadius: isSystemMsg
                ? const BorderRadius.all(Radius.circular(30))
                : isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))
                    : const BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.lightBlueAccent,
                    fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
