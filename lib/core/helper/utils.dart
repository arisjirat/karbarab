
import 'package:karbarab/core/config/game_mode.dart';

String gameModeToString(GameMode mode) {
  return mode.toString().substring(mode.toString().indexOf('.')+1);
}