import 'package:flutter/material.dart';

class GameDetailCard extends StatelessWidget {
  final String title;
  final String content;
  final bool isHighlight;

  const GameDetailCard({
    Key? key,
    required this.title,
    required this.content,
    this.isHighlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          isHighlight ? const Color.fromARGB(255, 244, 155, 54) : Colors.black,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: isHighlight
                  ? Colors.white
                  : const Color.fromARGB(255, 244, 155, 54),
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(content, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
