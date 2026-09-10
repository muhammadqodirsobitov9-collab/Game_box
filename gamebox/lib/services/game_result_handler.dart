import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'statistics_service.dart';
import 'progression_service.dart';

/// Every game widget calls this exactly once when a play session ends,
/// instead of talking to StatisticsService/ProgressionService directly.
/// This keeps "what happens when a game finishes" in one place — new
/// games (Part 5) and downloaded games (Part 4) just call this too.
class GameResultHandler {
  /// Reports the result, updates XP/coins/achievements, and — if any
  /// achievement was just unlocked — shows a small toast for it.
  /// Returns whether this was a new high score, in case the calling
  /// game wants to show its own "new high score!" banner.
  static Future<bool> report(
    BuildContext context, {
    required String gameId,
    required int score,
  }) async {
    final stats = context.read<StatisticsService>();
    final progression = context.read<ProgressionService>();

    final isNewHighScore = await stats.reportScore(gameId, score);
    final unlocked = await progression.awardForGame(
      gameId: gameId,
      isNewHighScore: isNewHighScore,
      allPlayedGameIds: stats.playedGameIds,
    );

    if (context.mounted) {
      for (final achievement in unlocked) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🏆 ${achievement.title} unlocked! +${achievement.coinReward} coins'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }

    return isNewHighScore;
  }
}
