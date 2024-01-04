import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final Function(String) onSearchChanged;

  const SearchInputField({Key? key, required this.onSearchChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Enter game name',
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}
