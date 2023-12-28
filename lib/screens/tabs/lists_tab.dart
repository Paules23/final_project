import 'package:flutter/material.dart';

class ListsTab extends StatelessWidget {
  final Future<List<String>> lists;

  const ListsTab(this.lists, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: lists,
      builder: (context, snapshot) {
        return const Center(child: Text('Lists Tab Content'));
      },
    );
  }
}
