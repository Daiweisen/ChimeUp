import 'package:flutter/material.dart';

class ToastCards extends StatelessWidget {
  final String title;
  final Widget leading;
  final String? subtitle;

  const ToastCards({
    super.key,
    required this.title,
    required this.leading,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12, // Reduced font size for title
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 5),
                    Text(
                      subtitle!,
                      style: const TextStyle(fontSize: 10), // Reduced font size for subtitle
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
