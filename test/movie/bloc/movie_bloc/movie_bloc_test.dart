import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository movieRepository;

  setUp(() {
    movieRepository = MockMovieRepository();
  });

  const movie = Movie(id: 1, title: 'title', backdropPath: 'backdropPath');

  group('MovieBloc', () {
    group('when PopularMoviesRequested', () {
      blocTest<MovieBloc, MovieState>(
        'emits [MovieStatus.loading, MovieStatus.success]'
        ' when movies are fetched successfully',
        setUp: () => when(() => movieRepository.getPopularMovies())
            .thenAnswer((_) async => const [movie]),
        build: () => MovieBloc(movieRepository: movieRepository),
        act: (bloc) => bloc.add(PopularMoviesRequested()),
        expect: () => [
          MovieState.initial().copyWith(status: MovieStatus.loading),
          MovieState.initial()
              .copyWith(status: MovieStatus.finished, movies: const [movie]),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'emits [MovieStatus.loading, MovieStatus.error]'
        ' when getPopularMovies throws',
        setUp: () => when(() => movieRepository.getPopularMovies())
            .thenThrow((_) async => Exception()),
        build: () => MovieBloc(movieRepository: movieRepository),
        act: (bloc) => bloc.add(PopularMoviesRequested()),
        expect: () => [
          MovieState.initial().copyWith(status: MovieStatus.loading),
          MovieState.initial().copyWith(
            status: MovieStatus.error,
          ),
        ],
      );
    });

    group('when SearchQueryChanged', () {
      blocTest<MovieBloc, MovieState>(
        'when movies are fetched successfully and query is empty '
        'emits [MovieStatus.loading, MovieStatus.success] '
        'calling getPopularMovies',
        setUp: () => when(() => movieRepository.getPopularMovies())
            .thenAnswer((_) async => const [movie]),
        build: () => MovieBloc(movieRepository: movieRepository),
        act: (bloc) => bloc.add(SearchQueryChanged('')),
        expect: () => [
          MovieState.initial().copyWith(status: MovieStatus.loading),
          MovieState.initial()
              .copyWith(status: MovieStatus.finished, movies: const [movie]),
        ],
        verify: (bloc) =>
            verify(() => movieRepository.getPopularMovies()).called(1),
      );

      blocTest<MovieBloc, MovieState>(
        'when movies are fetched successfully and query is not empty '
        'emits [MovieStatus.loading, MovieStatus.success] '
        'calling searchMovies debounced by 300 miliseconds',
        setUp: () => when(() => movieRepository.searchMovies(query: 'query'))
            .thenAnswer((_) async => const [movie]),
        build: () => MovieBloc(movieRepository: movieRepository),
        act: (bloc) => bloc.add(SearchQueryChanged('query')),
        wait: const Duration(milliseconds: 301),
        expect: () => [
          MovieState.initial().copyWith(status: MovieStatus.loading),
          MovieState.initial()
              .copyWith(status: MovieStatus.finished, movies: const [movie]),
        ],
        verify: (bloc) =>
            verify(() => movieRepository.searchMovies(query: 'query'))
                .called(1),
      );

      blocTest<MovieBloc, MovieState>(
        'when getPopularMovies throws '
        'emits [MovieStatus.loading, MovieStatus.error]',
        setUp: () => when(() => movieRepository.getPopularMovies())
            .thenThrow((_) async => Exception()),
        build: () => MovieBloc(movieRepository: movieRepository),
        act: (bloc) => bloc.add(SearchQueryChanged('')),
        expect: () => [
          MovieState.initial().copyWith(status: MovieStatus.loading),
          MovieState.initial().copyWith(
            status: MovieStatus.error,
          ),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'when searchMovies throws '
        'emits [MovieStatus.loading, MovieStatus.error] '
        'debounced by 300 miliseconds',
        setUp: () => when(() => movieRepository.searchMovies(query: 'query'))
            .thenThrow((_) async => Exception()),
        build: () => MovieBloc(movieRepository: movieRepository),
        act: (bloc) => bloc.add(SearchQueryChanged('query')),
        wait: const Duration(milliseconds: 301),
        expect: () => [
          MovieState.initial().copyWith(status: MovieStatus.loading),
          MovieState.initial().copyWith(
            status: MovieStatus.error,
          ),
        ],
      );
    });
  });
}
