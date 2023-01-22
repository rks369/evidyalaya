import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/models/message_model.dart';
import 'package:evidyalaya/widgets/message_bubbel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatelessWidget {
  final int reciverId;
  const Chat({super.key, required this.reciverId});

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;

    final TextEditingController msg = TextEditingController();

    final blocProvider = BlocProvider.of<AuthCubit>(context);

    late String chatId;
    if (blocProvider.userId < reciverId) {
      chatId = '${blocProvider.userId} $reciverId';
    } else if (blocProvider.userId > reciverId) {
      chatId = '$reciverId ${blocProvider.userId}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Chat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: fireStore.collection('message').doc(chatId).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                var messages = snapshot.data!.get('messages') as List;
                if (messages.isEmpty) {
                  return const Center(
                    child: Text('No message Exixts !!!'),
                  );
                }
                return ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                          text: messages[index]['msg'],
                          isMe: messages[index]['senderId'] ==
                              blocProvider.userId);
                    });
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: msg,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    fireStore
                        .collection('message')
                        .doc(chatId)
                        .get()
                        .then((value) {
                      if (value.exists) {
                        fireStore.collection("message").doc(chatId).update({
                          'messages': FieldValue.arrayUnion([
                            {
                              'msg': msg.text,
                              'time': DateTime.now(),
                              'senderId': blocProvider.userId,
                              'chatId': chatId
                            }
                          ])
                        }).then((value) {
                          msg.clear();
                        });
                      } else {
                        fireStore.collection("message").doc(chatId).set({
                          'messages': [
                            {
                              'msg': msg.text,
                              'time': DateTime.now(),
                              'senderId': blocProvider.userId,
                              'chatId': chatId
                            }
                          ]
                        }).then((value) {
                          msg.clear();
                        });
                      }
                    });
                  },
                  child: const Text('Send')),
            ],
          ),
        ],
      ),
    );
  }
}
