import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evidyalaya/bloc/auth_cubit.dart';
import 'package:evidyalaya/models/message_model.dart';
import 'package:evidyalaya/widgets/message_bubbel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;

    final TextEditingController msg = TextEditingController();

    final blocProvider = BlocProvider.of<AuthCubit>(context);

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
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  fireStore.collection('message').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                final messages = List.of(snapshot.data!.docs.reversed);

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
                          sender: messages[index].get('senderId').toString(),
                          text: messages[index].get('msg'),
                          isMe: true);
                    });
              },
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: msg,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      fireStore.collection("message").add({
                        'msg': msg.text,
                        'time': DateTime.now(),
                        'senderId': blocProvider.userId
                      });
                    },
                    child: const Text('Send')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
