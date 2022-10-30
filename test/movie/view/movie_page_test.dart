import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:hot_movies/shared/loading_content_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

import '../../helpers/helpers.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  group('MoviePage', () {
    testWidgets('has a route', (tester) async {
      expect(MoviePage.route(), isA<MaterialPageRoute<void>>());
    });

    testWidgets('when MoviePage route pushed navigates to MoviePage',
        (tester) async {
      await tester.pumpApp(
        Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () => Navigator.of(context).push(MoviePage.route()),
              child: const Text('Go to MoviePage'),
            );
          },
        ),
      );
      await tester.tap(find.text('Go to MoviePage'));
      await tester.pumpAndSettle();

      expect(find.byType(MoviePage), findsOneWidget);
    });

    testWidgets('renders MovieView', (tester) async {
      await tester.pumpApp(const MoviePage());
      expect(find.byType(MovieView), findsOneWidget);
    });

    testWidgets('provides MovieBloc to MovieView', (tester) async {
      await tester.pumpApp(const MoviePage());
      final BuildContext viewContext = tester.element(find.byType(MovieView));
      expect(viewContext.read<MovieBloc>(), isNotNull);
    });
  });

  group('MovieView', () {
    late MovieBloc movieBloc;

    setUp(() {
      movieBloc = MockMovieBloc();
      when(() => movieBloc.state)
          .thenAnswer((invocation) => MovieState.initial());
    });

    registerFallbackValue(SearchQueryChanged('query'));
    group('renders MovieSearchAppBar', () {
      testWidgets('correctly', (tester) async {
        await tester.pumpApp(
          BlocProvider.value(
            value: movieBloc,
            child: const MovieView(),
          ),
        );

        expect(find.byType(MovieSearchAppBar), findsOneWidget);
      });

      testWidgets('adds SearchQueryChanged when onSearchQueryChanged called',
          (tester) async {
        await tester.pumpApp(
          BlocProvider.value(
            value: movieBloc,
            child: const MovieView(),
          ),
        );

        final searchAppBar = tester.widget<MovieSearchAppBar>(
          find.byType(MovieSearchAppBar),
        );
        searchAppBar.onSearchQueryChanged('query');

        verify(() => movieBloc.add(SearchQueryChanged('query'))).called(1);
      });
    });

    group('when movieBloc.status ==', () {
      final movies = [
        const Movie(id: 1, title: 'title', backdropPath: 'backdropPath'),
        const Movie(id: 2, title: 'title', backdropPath: 'backdropPath'),
      ];

      testWidgets(
          'loading, '
          'renders CircularProgressIndicator', (tester) async {
        when(() => movieBloc.state).thenAnswer(
          (invocation) =>
              MovieState.initial().copyWith(status: MovieStatus.loading),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: movieBloc,
            child: const MovieView(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      group('finished,', () {
        testWidgets('renders ListTile for each movie in MovieBloc',
            (tester) async {
          when(() => movieBloc.state).thenAnswer(
            (invocation) => MovieState.initial().copyWith(
              status: MovieStatus.finished,
              movies: movies,
            ),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: movieBloc,
              child: const MovieView(),
            ),
          );

          expect(find.byType(ListTile), findsNWidgets(movies.length));
        });

        testWidgets('when ListTile is tapped, navigates to MovieDetailsPage',
            (tester) async {
          when(() => movieBloc.state).thenAnswer(
            (invocation) => MovieState.initial().copyWith(
              status: MovieStatus.finished,
              movies: movies,
            ),
          );

          await tester.pumpApp(
            BlocProvider.value(
              value: movieBloc,
              child: const MovieView(),
            ),
          );

          await tester.tap(find.byType(ListTile).first);
          await tester.pumpAndSettle();

          expect(find.byType(MovieDetailsPage), findsOneWidget);
        });
      });

      group('error,', () {
        setUp(() {
          when(() => movieBloc.state).thenAnswer(
            (invocation) => MovieState.initial().copyWith(
              status: MovieStatus.error,
            ),
          );
        });

        testWidgets('renders LoadingContentError', (tester) async {
          await tester.pumpApp(
            BlocProvider.value(
              value: movieBloc,
              child: const MovieView(),
            ),
          );

          expect(find.byType(LoadingContentError), findsOneWidget);
        });

        testWidgets('when onRetry called adds PopularMoviesRequested',
            (tester) async {
          await tester.pumpApp(
            BlocProvider.value(
              value: movieBloc,
              child: const MovieView(),
            ),
          );

          final loadingContentError = tester.widget<LoadingContentError>(
            find.byType(LoadingContentError),
          );
          loadingContentError.onRetry!();

          verify(() => movieBloc.add(PopularMoviesRequested())).called(1);
        });
      });
    });
  });
}
