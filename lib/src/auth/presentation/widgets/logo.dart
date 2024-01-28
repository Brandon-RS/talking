import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.text,
    this.version,
  });

  final String? text;
  final String? version;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = Text(
      text ?? 'Talking',
      style: textTheme.headlineMedium,
    );

    final titleWidget = version != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              title,
              const SizedBox(width: 4),
              Text(
                version!,
                style: textTheme.bodySmall,
              ),
            ],
          )
        : title;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top + 30),
          const Icon(Icons.person_pin, size: 140),
          const SizedBox(height: 22),
          titleWidget,
        ],
      ),
    );
  }
}
