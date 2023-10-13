import 'package:flutter/material.dart';

class TitledText extends StatelessWidget {
  final String title;
  final String content;
  final Widget? suffix;

  const TitledText({
    super.key,
    required this.title,
    required this.content,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: content),
            if (suffix != null) ...[
              const WidgetSpan(
                child: SizedBox(
                  width: 8,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: suffix!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
