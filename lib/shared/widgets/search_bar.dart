import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onSubmitted: widget.onSearch,
      decoration: InputDecoration(
        hintText: 'Pesquisar...',
        suffixIcon: InkWell(
          onTap: () => widget.onSearch(_searchController.text),
          child: const Icon(Icons.search_rounded),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
