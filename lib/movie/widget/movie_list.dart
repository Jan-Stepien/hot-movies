import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    super.key,
    required this.movies,
    required this.onLoadMore,
  });

  final List<Movie> movies;
  final VoidCallback onLoadMore;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.movies.length,
        itemBuilder: (context, index) => ListTile(
          key: ValueKey(widget.movies[index]),
          onTap: () => Navigator.of(context).push(
            MovieDetailsPage.route(id: widget.movies[index].id),
          ),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.background,
            backgroundImage: widget.movies[index].backdropPath != null
                ? CachedNetworkImageProvider(
                    widget.movies[index].backdropPath!,
                  )
                : null,
          ),
          title: Text(widget.movies[index].title),
          trailing: const Icon(Icons.chevron_right),
        ),
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  void _scrollListener() {
    if (scrollController.position.extentAfter < 300) {
      widget.onLoadMore();
    }
  }
}
