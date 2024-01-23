import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and conditions'),
      ),
      body: FutureBuilder<String>(
        future: loadMarkdown(),
        builder: (context, snapshot) => snapshot.hasData
            ? Scrollbar(
                child: Markdown(
                  data: snapshot.data!,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    p: textTheme.bodyMedium?.copyWith(fontSize: 15),
                    h2: textTheme.titleMedium,
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<String> loadMarkdown() async {
    return await rootBundle.loadString('assets/terms_conditions/terms_and_conditions.md');
  }
}
