import 'package:flutter/material.dart';
import 'package:hot_movies/l10n/l10n.dart';

class MovieSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MovieSearchAppBar({super.key, required this.onSearchQueryChanged});

  final ValueSetter<String> onSearchQueryChanged;

  @override
  State<MovieSearchAppBar> createState() => _MovieSearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MovieSearchAppBarState extends State<MovieSearchAppBar> {
  final _searchController = TextEditingController();
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return AppBar(
      centerTitle: false,
      title: isSearchVisible
          ? TextField(
              controller: _searchController,
              autofocus: true,
              cursorColor: onPrimary,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: onPrimary,
                  ),
              onChanged: widget.onSearchQueryChanged,
            )
          : Text(context.l10n.movieViewerTitle),
      actions: [
        if (isSearchVisible)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              if (_searchController.value.text.isEmpty) {
                setState(() => isSearchVisible = false);
              } else {
                _searchController.clear();
                widget.onSearchQueryChanged('');
              }
            },
          )
        else
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => setState(() {
              isSearchVisible = true;
            }),
          ),
      ],
    );
  }
}
