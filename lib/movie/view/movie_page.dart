import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_movies/l10n/l10n.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:movie_repository/movie_repository.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const MoviePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => MovieBloc(
        movieRepository: context.read<MovieRepository>(),
      )..add(PopularMoviesRequested()),
      child: const MovieView(),
    );
  }
}

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = context.select<MovieBloc, List<Movie>>(
      (bloc) => bloc.state.movies,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(context.l10n.movieViewerTitle),
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) => ListTile(
            key: ValueKey(movies[index]),
            onTap: () => Navigator.of(context).push(
              MovieDetailsPage.route(id: movies[index].id),
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.background,
              backgroundImage: movies[index].backdropPath != null
                  ? CachedNetworkImageProvider(
                      movies[index].backdropPath!,
                    )
                  : null,
            ),
            title: Text(movies[index].title),
            trailing: const Icon(Icons.chevron_right),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
