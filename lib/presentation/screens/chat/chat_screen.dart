import 'package:flutter/material.dart';
import 'package:talking/configs/colors/generic_colors.dart';
import 'package:talking/presentation/screens/chat/widgets/chat.widgets.dart';

import 'widgets/chat_appbar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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

                return Align(
                  alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: isMe ? Theme.of(context).primaryColor : TColors.white,
                    ),
                    child: Text(
                      'Message $index',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isMe ? TColors.white : null,
                          ),
                    ),
                  ),
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
