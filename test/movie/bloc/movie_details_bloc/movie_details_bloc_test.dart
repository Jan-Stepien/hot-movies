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

  const movieDetails = MovieDetails(
    id: 1,
    overview: 'overview',
    voteAverage: 1,
    title: 'title',
    backdropPath: 'backdropPath',
  );

  group('MovieDetailsBloc', () {
    group('when DetailsRequested', () {
      blocTest<MovieDetailsBloc, MovieDetailsState>(
        'emits [MovieStatus.loading, MovieStatus.success]'
        ' when movie details are fetched successfully',
        setUp: () => when(() => movieRepository.getMovieDetails(id: 1))
            .thenAnswer((_) async => movieDetails),
        build: () => MovieDetailsBloc(id: 1, movieRepository: movieRepository),
        act: (bloc) => bloc.add(DetailsRequested()),
        expect: () => [
          MovieDetailsState.initial(id: 1)
              .copyWith(status: MovieDetailsStatus.loading),
          MovieDetailsState.initial(id: 1).copyWith(
            status: MovieDetailsStatus.finished,
            details: movieDetails,
          ),
        ],
        verify: (bloc) =>
            verify(() => movieRepository.getMovieDetails(id: 1)).called(1),
      );

      blocTest<MovieDetailsBloc, MovieDetailsState>(
        'emits [MovieStatus.loading, MovieStatus.error]'
        ' when getMovieDetails throws',
        setUp: () => when(() => movieRepository.getMovieDetails(id: 1))
            .thenThrow((_) async => Exception()),
        build: () => MovieDetailsBloc(id: 1, movieRepository: movieRepository),
        act: (bloc) => bloc.add(DetailsRequested()),
        expect: () => [
          MovieDetailsState.initial(id: 1)
              .copyWith(status: MovieDetailsStatus.loading),
          MovieDetailsState.initial(id: 1).copyWith(
            status: MovieDetailsStatus.error,
          ),
        ],
        verify: (bloc) =>
            verify(() => movieRepository.getMovieDetails(id: 1)).called(1),
      );
    });
  });
}
