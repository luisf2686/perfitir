import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconText({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
