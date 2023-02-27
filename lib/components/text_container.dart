import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      width: MediaQuery.of(context).size.width * 0.85,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}