import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    super.key,
    required this.onChanged,
  });

  final Function(String newValue) onChanged;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      hintText: 'Search by character name...',
      onChanged: widget.onChanged,
    );
  }
}
