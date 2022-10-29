import 'package:flutter/material.dart';
import 'package:hot_movies/l10n/l10n.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
