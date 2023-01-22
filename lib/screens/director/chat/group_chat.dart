import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/widgets/group_message_bubbel.dart';
import 'package:evidyalaya/widgets/message_bubbel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupChat extends StatelessWidget {
  final int groupId;
  final String groupName;
  const GroupChat({super.key, required this.groupId, required this.groupName});

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;

    final TextEditingController msg = TextEditingController();

    final blocProvider = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.group),
            const SizedBox(
              width: 10,
            ),
            Text(
              groupName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: fireStore
                  .collection('groupChat')
                  .doc(groupId.toString())
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                var messages = snapshot.data!.get('messages') as List;
                messages = messages.reversed.toList();
                if (messages.isEmpty) {
                  return const Center(
                    child: Text('No message Exixts !!!'),
                  );
                }
                return ListView.builder(
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return GroupMessageBubble(
                          senderName: messages[index]['senderName'],
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
                        .collection('groupChat')
                        .doc(groupId.toString())
                        .get()
                        .then((value) {
                      if (value.exists) {
                        fireStore
                            .collection("groupChat")
                            .doc(groupId.toString())
                            .update({
                          'messages': FieldValue.arrayUnion([
                            {
                              'msg': msg.text,
                              'time': DateTime.now(),
                              'senderId': blocProvider.userId,
                              'senderName': blocProvider.userModel!.name
                            }
                          ])
                        }).then((value) {
                          msg.clear();
                        });
                      } else {
                        fireStore
                            .collection("groupChat")
                            .doc(groupId.toString())
                            .set({
                          'messages': [
                            {
                              'msg': msg.text,
                              'time': DateTime.now(),
                              'senderId': blocProvider.userId,
                              'senderName': blocProvider.userModel!.name
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
