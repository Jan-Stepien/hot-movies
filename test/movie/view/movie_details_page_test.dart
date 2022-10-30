import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:hot_movies/shared/loading_content_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

import '../../helpers/helpers.dart';

class MockMovieDetailsBloc
    extends MockBloc<MovieDetailsEvent, MovieDetailsState>
    implements MovieDetailsBloc {}

void main() {
  group('MovieDetailsPage', () {
    testWidgets('has a route', (tester) async {
      expect(MovieDetailsPage.route(id: 1), isA<MaterialPageRoute<void>>());
    });

    testWidgets('renders MovieDetailsView', (tester) async {
      await tester.pumpApp(const MovieDetailsPage(id: 1));
      expect(find.byType(MovieDetailsView), findsOneWidget);
    });

    testWidgets('provides MovieDetailsBloc to MovieDetailsView',
        (tester) async {
      await tester.pumpApp(const MovieDetailsPage(id: 1));
      final BuildContext viewContext =
          tester.element(find.byType(MovieDetailsView));
      expect(viewContext.read<MovieDetailsBloc>(), isNotNull);
    });
  });

  group('MovieDetailsView', () {
    late MovieDetailsBloc movieDetailsBloc;

    setUp(() {
      movieDetailsBloc = MockMovieDetailsBloc();
      when(() => movieDetailsBloc.state)
          .thenAnswer((invocation) => MovieDetailsState.initial(id: 1));
    });

    group('when movieBloc.status ==', () {
      const movieDetails = MovieDetails(
        id: 1,
        overview: 'overview',
        voteAverage: 1,
        title: 'title',
        backdropPath: 'backdropPath',
      );

      testWidgets(
          'loading, '
          'renders CircularProgressIndicator', (tester) async {
        when(() => movieDetailsBloc.state).thenAnswer(
          (invocation) => MovieDetailsState.initial(id: 1)
              .copyWith(status: MovieDetailsStatus.loading),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: movieDetailsBloc,
            child: const MovieDetailsView(),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets(
          'finished'
          'renders HeadshotImage, ScoreBadge and Overview', (tester) async {
        when(() => movieDetailsBloc.state).thenAnswer(
          (invocation) => MovieDetailsState.initial(id: 1).copyWith(
            status: MovieDetailsStatus.finished,
            details: movieDetails,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: movieDetailsBloc,
            child: const MovieDetailsView(),
          ),
        );

        expect(find.byType(HeadshotImage), findsOneWidget);
        expect(find.byType(ScoreBadge), findsOneWidget);
        expect(find.text(movieDetails.overview!), findsOneWidget);
      });

      group('error,', () {
        setUp(() {
          when(() => movieDetailsBloc.state).thenAnswer(
            (invocation) => MovieDetailsState.initial(id: 1).copyWith(
              status: MovieDetailsStatus.error,
            ),
          );
        });

        testWidgets('renders LoadingContentError', (tester) async {
          await tester.pumpApp(
            BlocProvider.value(
              value: movieDetailsBloc,
              child: const MovieDetailsView(),
            ),
          );

          expect(find.byType(LoadingContentError), findsOneWidget);
        });

        testWidgets('when onRetry called adds DetailsRequested',
            (tester) async {
          await tester.pumpApp(
            BlocProvider.value(
              value: movieDetailsBloc,
              child: const MovieDetailsView(),
            ),
          );

          final loadingContentError = tester.widget<LoadingContentError>(
            find.byType(LoadingContentError),
          );
          loadingContentError.onRetry!();

          verify(() => movieDetailsBloc.add(DetailsRequested())).called(1);
        });
      });
    });
  });
}
