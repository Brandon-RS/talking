import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talking/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:talking/src/chat/domain/entities/message_entity.dart';
import 'package:talking/src/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:talking/src/chat/presentation/widgets/chat.widgets.dart';
import 'package:talking/src/user/domain/entities/user_entity.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          final chats = state.messages;
          final targetUser = state.recipient;

          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final user = authState.user;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: chats.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final isMe = chats[index].from == user.uid;

                        return BubbleChat(
                          text: chats[index].text,
                          isMine: isMe,
                        );
                      },
                    ),
                  ),
                  MessageInputField(
                    onSubmitted: (value) {
                      if (user == User.empty) {
                        return;
                      }

                      final message = Message(
                        from: user.uid,
                        to: targetUser.uid,
                        text: value,
                      );

                      context.read<ChatBloc>().add(SendMessage(message));
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
