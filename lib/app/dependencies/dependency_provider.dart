import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_movies/app/dependencies/environment_strings_keys.dart';
import 'package:http_client/http_client.dart';
import 'package:movie_client/movie_client.dart';
import 'package:movie_repository/movie_repository.dart';

class DependencyProvider extends StatelessWidget {
  const DependencyProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final movieClient = MovieClient(
      httpClient: HttpClient(),
      baseUrl: const String.fromEnvironment(
        EnvironmentStringsKeys.baseMoviesUrl,
      ),
      apiKey: const String.fromEnvironment(
        EnvironmentStringsKeys.moviesAPiKey,
      ),
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (_) => MovieRepository(
            movieClient: movieClient,
          ),
        ),
      ],
      child: child,
    );
  }
}
