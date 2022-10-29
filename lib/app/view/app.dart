import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hot_movies/app/dependencies/dependency_provider.dart';
import 'package:hot_movies/l10n/l10n.dart';
import 'package:hot_movies/movie/movie.dart';
import 'package:hot_movies/style/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyProvider(
      child: MaterialApp(
        theme: AppTheme().themeData,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: MoviePage.routeName,
        routes: {
          MoviePage.routeName: (_) => const MoviePage(),
        },
      ),
    );
  }
}
