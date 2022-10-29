import 'package:flutter/material.dart';
import 'package:hot_movies/style/style.dart';

class ScoreBadge extends StatelessWidget {
  const ScoreBadge({
    super.key,
    required this.score,
    required this.size,
  });

  final double? score;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.paddingxl),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Transform.translate(
          offset: Offset(
            0,
            size / 2,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.paddingxs),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.progressIndicatorColor,
                    value: score != null ? score! / 10 : 0,
                  ),
                ),
              ),
              Text(
                score != null ? '${(score! * 10).round()}%' : '',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
