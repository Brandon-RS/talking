import 'package:flutter/material.dart';

import 'widgets/chat.widgets.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              itemCount: 30,
              reverse: true,
              itemBuilder: (context, index) {
                final isMe = index % 2 == 0;

                return BubbleChat(
                  text: 'Message $index',
                  uuid: isMe ? 'me' : 'other',
                );
              },
            ),
          ),
          MessageInputField(
            onSubmitted: (value) {},
          ),
        ],
      ),
    );
  }
}
