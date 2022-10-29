import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_movies/l10n/localization.dart';
import 'package:hot_movies/movie/movie.dart';

class MovieSearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MovieSearchAppBar({super.key});

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
              onChanged: (query) =>
                  context.read<MovieBloc>().add(SearchQueryChanged(query)),
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
                context.read<MovieBloc>().add(SearchQueryChanged(''));
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
