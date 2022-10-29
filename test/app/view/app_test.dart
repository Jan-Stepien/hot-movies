import 'package:flutter_test/flutter_test.dart';
import 'package:hot_movies/app/app.dart';
import 'package:hot_movies/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
