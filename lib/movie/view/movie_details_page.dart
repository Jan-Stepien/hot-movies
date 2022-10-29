import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:hot_movies/shared/loading_content_error.dart';
import 'package:hot_movies/style/style.dart';
import 'package:movie_repository/movie_repository.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({
    super.key,
    required this.id,
  });

  static Route<void> route({
    required int id,
  }) =>
      MaterialPageRoute<void>(
        builder: (_) => MovieDetailsPage(
          id: id,
        ),
      );

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieDetailsBloc>(
      create: (_) => MovieDetailsBloc(
        id: id,
        movieRepository: context.read<MovieRepository>(),
      )..add(DetailsRequested()),
      child: const MovieDetailsView(),
    );
  }
}

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = context.select<MovieDetailsBloc, String?>(
      (bloc) => bloc.state.details?.backdropPath,
    );
    final score = context.select<MovieDetailsBloc, double?>(
      (bloc) => bloc.state.details?.voteAverage,
    );
    final overview = context.select<MovieDetailsBloc, String?>(
      (bloc) => bloc.state.details?.overview,
    );
    final title = context.select<MovieDetailsBloc, String?>(
      (bloc) => bloc.state.details?.title,
    );
    final isLoading = context.select<MovieDetailsBloc, bool>(
      (bloc) => bloc.state.status == MovieDetailsStatus.loading,
    );
    final isLoaded = context.select<MovieDetailsBloc, bool>(
      (bloc) => bloc.state.status == MovieDetailsStatus.finished,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.padding,
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : isLoaded
                ? ListView(
                    children: [
                      const SizedBox(height: AppSpacing.padding),
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          HeadshotImage(
                            imageUrl: imageUrl,
                          ),
                          ScoreBadge(score: score, size: AppSpacing.iconSizexl),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.paddingxxl),
                      Text(
                        overview ?? '',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  )
                : LoadingContentError(
                    onRetry: () => context
                        .read<MovieDetailsBloc>()
                        .add(DetailsRequested()),
                  ),
      ),
    );
  }
}
