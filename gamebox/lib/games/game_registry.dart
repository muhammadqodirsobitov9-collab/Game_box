import 'package:flutter/widgets.dart';
import '../models/game_model.dart';
import 'snake_game.dart';
import 'tic_tac_toe_game.dart';
import 'runner_game.dart';
import 'memory_game.dart';
import 'puzzle_2048_game.dart';
import 'whack_a_mole_game.dart';
import 'reaction_time_game.dart';
import 'simon_says_game.dart';
import 'rock_paper_scissors_game.dart';
import 'number_guess_game.dart';
import 'minesweeper_game.dart';
import 'connect_four_game.dart';
import 'sliding_puzzle_game.dart';
import 'word_scramble_game.dart';
import 'higher_lower_game.dart';
import 'brick_breaker_game.dart';
import 'mini_sudoku_game.dart';
import 'match_three_game.dart';
import 'typing_speed_game.dart';
import 'dice_duel_game.dart';
import 'fruit_slice_game.dart';
import 'flappy_block_game.dart';
import 'pong_game.dart';
import 'hangman_game.dart';
import 'speed_math_game.dart';
import 'quiz_trivia_game.dart';
import 'battleship_game.dart';
import 'maze_escape_game.dart';
import 'color_match_game.dart';

/// Maps a [GameModel.engineKey] to its actual playable screen.
///
/// Adding a new built-in game only means adding one case here plus a
/// new file under lib/games/ — nothing else in the app needs to
/// change, which mirrors the "scalable catalog" requirement even
/// before the downloadable-package system exists.
class GameRegistry {
  static Widget? widgetFor(GameModel game) {
    switch (game.engineKey) {
      case 'snake':
        return SnakeGame(game: game);
      case 'tic_tac_toe':
        return TicTacToeGame(game: game);
      case 'runner':
        return RunnerGame(game: game);
      case 'memory':
        return MemoryGame(game: game);
      case 'puzzle_2048':
        return Puzzle2048Game(game: game);
      case 'whack_a_mole':
        return WhackAMoleGame(game: game);
      case 'reaction_time':
        return ReactionTimeGame(game: game);
      case 'simon_says':
        return SimonSaysGame(game: game);
      case 'rock_paper_scissors':
        return RockPaperScissorsGame(game: game);
      case 'number_guess':
        return NumberGuessGame(game: game);
      case 'minesweeper':
        return MinesweeperGame(game: game);
      case 'connect_four':
        return ConnectFourGame(game: game);
      case 'sliding_puzzle':
        return SlidingPuzzleGame(game: game);
      case 'word_scramble':
        return WordScrambleGame(game: game);
      case 'higher_lower':
        return HigherLowerGame(game: game);
      case 'brick_breaker':
        return BrickBreakerGame(game: game);
      case 'mini_sudoku':
        return MiniSudokuGame(game: game);
      case 'match_three':
        return MatchThreeGame(game: game);
      case 'typing_speed':
        return TypingSpeedGame(game: game);
      case 'dice_duel':
        return DiceDuelGame(game: game);
      case 'fruit_slice':
        return FruitSliceGame(game: game);
      case 'flappy_block':
        return FlappyBlockGame(game: game);
      case 'pong':
        return PongGame(game: game);
      case 'hangman':
        return HangmanGame(game: game);
      case 'speed_math':
        return SpeedMathGame(game: game);
      case 'quiz_trivia':
        return QuizTriviaGame(game: game);
      case 'battleship':
        return BattleshipGame(game: game);
      case 'maze_escape':
        return MazeEscapeGame(game: game);
      case 'color_match':
        return ColorMatchGame(game: game);
      default:
        return null;
    }
  }
}
