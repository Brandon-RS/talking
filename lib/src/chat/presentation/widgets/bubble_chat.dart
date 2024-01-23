import 'package:flutter/material.dart';
import 'package:talking/configs/colors/generic_colors.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({
    super.key,
    required this.text,
    required this.isMine,
  });

  final String text;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: !isMine ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 2,
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: !isMine ? Theme.of(context).primaryColor : TColors.white,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: !isMine ? TColors.white : null,
              ),
        ),
      ),
    );
  }
}
