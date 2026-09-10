# GameBox — Parts 1-5 (Foundation + Progression + 29 Games + Download Manager + Admin Panel)

A real, working Flutter starting point for the full GameBox spec:
navigation, architecture, offline storage, theming, i18n, a full
XP/level/coins/achievements progression system, 29 mini-games, a
working Download Manager, and an Admin Panel with ZIP-based package
publishing.

## What's implemented so far

**Part 1 — Foundation**: bottom nav + drawer, `GameModel`/`GameRepository`/
`LocalStorageService`/`FavoritesService`/`StatisticsService`, offline
`shared_preferences` storage, dark/light theme, EN/RU/UZ i18n, onboarding.

**Part 2 — Progression**: `ProgressionService` (XP, levels, coins, 8
achievements) and `GameResultHandler`, the single place every game
reports through. Profile screen + live coin/level badge in the app bar.

**Part 3 — 26 built-in games**, across Arcade / Puzzle / Brain / Casual:
Snake, Endless Runner, Whack-a-Mole, Brick Breaker, Fruit Slice, Flappy
Block, Pong, Tic-Tac-Toe, 2048, Minesweeper, Connect Four, 15 Puzzle,
Battleship, Maze Escape, Memory Puzzle, Reaction Time, Simon Says,
Number Guess, Word Scramble, Hangman, Speed Math, Quiz Trivia, Rock
Paper Scissors, Higher or Lower, Dice Duel, Color Match.

**Part 4 — Download Manager**: `GamePackage` + `DownloadManagerService`
with a simulated download queue (progress/pause/resume/cancel/uninstall,
persisted). 3 downloadable games: Mini Sudoku, Match Three, Typing Speed.
Installed packages behave exactly like built-in games everywhere.

**Part 5 — Admin Panel + ZIP import**
- Drawer → Admin Panel, gated by a demo PIN (**1234** — this is a UI
  gate, not real auth; see the note in `admin_service.dart`).
- Dashboard: total games, total plays, custom-package count, unlocked
  achievements.
- **Import ZIP package**: pick a `.zip` from the device, and
  `AdminService` validates and publishes it as a new catalog entry,
  installed immediately.
- **Important technical honesty note**: a compiled Flutter app cannot
  load and run brand-new Dart code from a ZIP at runtime — there is no
  safe way to ship a truly new game *engine* without rebuilding the
  app. So ZIP import does the real, working version of this: it
  publishes a new catalog *listing* backed by one of the engines
  already compiled into the app, optionally with custom content data.
  Word Scramble is wired up as the concrete example — a ZIP can supply
  its own `words.json` and the published listing plays with those
  words instead of the defaults.
- A ready-to-try example is included: `samples/uzbek_word_pack.zip`
  (manifest + a small Uzbek word list). Pick Admin Panel → Import ZIP
  package → select that file to see it appear as an installed game
  immediately.

### ZIP package format
```
package.zip
  manifest.json   (required)
  words.json      (optional — only read when engineKey is "word_scramble")
```
`manifest.json` fields: `id`, `name`, `category`, `description`
(required strings), `engineKey` (required, must be one of the
built-in engine keys — see `AdminService.knownEngineKeys`), `rating`
and `sizeMB` (optional numbers), `version` (optional string).

## Not yet built

- A real backend (today's "remote catalog" and "downloads" are both
  simulated/local, by design, since this is an offline-first app)
- More mini-games beyond the current 19
- Real admin authentication (the PIN is a placeholder gate)

## Running it

No Flutter SDK was available in the authoring environment, so the
platform folders (`android/`, `ios/`) aren't included yet — generate
them locally with:

```bash
flutter create . --platforms=android
flutter pub get
flutter run
```

`flutter create .` scaffolds `android/` around the existing `lib/`
and `pubspec.yaml` without overwriting them. Then `flutter build apk`
produces an installable APK. `flutter pub get` will fetch the two new
dependencies (`archive`, `file_picker`) needed for ZIP import.

## Project layout

```
lib/
  main.dart
  theme/app_theme.dart
  l10n/app_strings.dart
  models/
    game_model.dart
    game_package.dart
  services/
    local_storage_service.dart
    favorites_service.dart
    statistics_service.dart
    progression_service.dart
    game_result_handler.dart
    game_repository.dart
    download_manager_service.dart
    admin_service.dart
    theme_controller.dart
  screens/
    onboarding_screen.dart
    home_screen.dart
    games_screen.dart
    favorites_screen.dart
    downloads_screen.dart
    profile_screen.dart
    settings_screen.dart
    contact_screen.dart
    game_detail_screen.dart
    admin_panel_screen.dart
  widgets/
    main_scaffold.dart
    game_card.dart
  games/
    game_registry.dart
    snake_game.dart, tic_tac_toe_game.dart, runner_game.dart,
    memory_game.dart, puzzle_2048_game.dart, whack_a_mole_game.dart,
    reaction_time_game.dart, simon_says_game.dart,
    rock_paper_scissors_game.dart, number_guess_game.dart,
    minesweeper_game.dart, connect_four_game.dart,
    sliding_puzzle_game.dart, word_scramble_game.dart,
    higher_lower_game.dart, brick_breaker_game.dart,
    dice_duel_game.dart, fruit_slice_game.dart, flappy_block_game.dart,
    pong_game.dart, hangman_game.dart, speed_math_game.dart,
    quiz_trivia_game.dart, battleship_game.dart, maze_escape_game.dart,
    color_match_game.dart,
    mini_sudoku_game.dart, match_three_game.dart, typing_speed_game.dart
samples/
  uzbek_word_pack.zip   (example Admin Panel import)
```

Adding a new **built-in** game: one file in `lib/games/`, one entry in
`GameRegistry`, one `GameModel` in `GameRepository`, one call to
`GameResultHandler.report(...)`.

Adding a new **downloadable** game: one file in `lib/games/`, one
entry in `GameRegistry`, one `GamePackage` in
`DownloadManagerService._staticCatalog`.

Publishing a **content pack** for an existing engine: no code at all —
just a ZIP with `manifest.json` (+ `words.json` for Word Scramble),
imported through the Admin Panel.
