import 'package:flutter/material.dart';
import 'package:talking/configs/colors/generic_colors.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({
    super.key,
    required this.text,
    required this.uuid,
  });

  final String text;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    // TODO(BRANDOM): Just for testing, remove this
    final isMe = uuid == 'me';

    return Align(
      alignment: !isMe ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: !isMe ? Theme.of(context).primaryColor : TColors.white,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: !isMe ? TColors.white : null,
              ),
        ),
      ),
    );
  }
}
