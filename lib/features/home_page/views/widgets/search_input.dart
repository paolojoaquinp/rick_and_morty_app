import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.onChanged,
  });

  final Function(String newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: TextEditingController(),
      hintText: 'Type yout favorite character name...',
      onChanged: onChanged,
    );
  }
}
