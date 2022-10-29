import 'package:flutter/material.dart';
import 'package:hot_movies/l10n/localization.dart';
import 'package:hot_movies/style/style.dart';

class LoadingContentError extends StatelessWidget {
  const LoadingContentError({super.key, required this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.l10n.problemLoadingContentMessage),
          const SizedBox(height: AppSpacing.padding),
          if (onRetry != null)
            OutlinedButton(
              onPressed: onRetry,
              child: Text(context.l10n.refresh),
            ),
        ],
      ),
    );
  }
}
