import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  onTapLink: (text, href, title) async {
                    if (href != null) {
                      await _launchUri(href, text);
                    }
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Future<void> _launchUri(String href, String text) async {
    if (href.startsWith('mailto:')) {
      final uri = Uri(
        scheme: 'mailto',
        path: text,
        query: encodeQueryParameters({
          'subject': 'About Talking Chatting App',
          'body': 'Share your doubts with us!',
        }),
      );

      await launchUrl(uri);
    } else {
      final uri = Uri.tryParse(href);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }

  Future<String> loadMarkdown() async {
    return await rootBundle.loadString('assets/terms_conditions/terms_and_conditions.md');
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
