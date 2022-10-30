import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:hot_movies/shared/loading_content_error.dart';
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
    final isLoading = context.select<MovieBloc, bool>(
      (bloc) => bloc.state.status == MovieStatus.loading,
    );
    final isLoaded = context.select<MovieBloc, bool>(
      (bloc) => bloc.state.status == MovieStatus.finished,
    );

    return Scaffold(
      appBar: MovieSearchAppBar(
        onSearchQueryChanged: (query) =>
            context.read<MovieBloc>().add(SearchQueryChanged(query)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isLoaded
              ? MovieList(
                  movies: movies,
                  onLoadMore: () =>
                      context.read<MovieBloc>().add(LoadMoreMoviesRequested()),
                )
              : LoadingContentError(
                  onRetry: () => context.read<MovieBloc>().add(
                        PopularMoviesRequested(),
                      ),
                ),
    );
  }
}
