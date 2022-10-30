import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/movie/movie.dart';

void main() {
  group('MovieDetailsEvent', () {
    test('DetailsRequested supports value comparisons', () {
      expect(DetailsRequested(), DetailsRequested());
    });
  });
}
