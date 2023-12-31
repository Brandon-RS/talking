import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({
    super.key,
    this.onSubmitted,
  });

  final ValueChanged<String>? onSubmitted;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
                onSubmitted: (_) => _onSendMessage(),
                // TODO(BRANDOM): Avoid the set state here
                onChanged: (value) => setState(() {}),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: _controller.text.trim().isNotEmpty ? _onSendMessage : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onSendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSubmitted?.call(_controller.text);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }
}
