
import 'dart:math';

import 'package:karbarab/core/config/game_mode.dart';
import 'package:karbarab/core/config/score_value.dart';

// enum CardCategory { Animal, Plant, Fruit, Object }

// String cardCategoryToString(CardCategory cardCategory) {
//   return cardCategory.toString().substring(cardCategory.toString().indexOf('.')+1);
// }

// CardCategory stringToCardCategory(String cardCategory) {
//   switch (cardCategory) {
//     case 'Animal':
//       return CardCategory.Animal;
//     case 'Plant':
//       return CardCategory.Plant;
//     case 'Fruit':
//       return CardCategory.Fruit;
//     case 'Object':
//       return CardCategory.Object;
//     default:
//     return CardCategory.Object;
//   }
// }

// String gameModeToString(GameMode mode) {
//   return mode.toString().substring(mode.toString().indexOf('.')+1);
// }

// GameMode stringToGameMode(String mode) {
//   switch (mode) {
//     case 'GambarArab':
//       return GameMode.GambarArab;
//     case 'ArabGambar':
//       return GameMode.ArabGambar;
//     case 'KataArab':
//       return GameMode.KataArab;
//     case 'ArabKata':
//       return GameMode.ArabKata;
//     default:
//     return GameMode.ArabGambar;
//   }
// }

List<List<String>> words = [
  [
    'Huft, Kamu belum tau ya?',
    'Sekarang udah tau kan?',
    'Coba Lagi ya!',
  ],
  [
    'Soalnya sulit ya?',
    'Jangan Menyerah!',
    'Hmm, Coba fokus!',
  ],
  [
    'Yeay! sedikit lagi!',
    'Bagus! jangan salah lagi ya',
    'Hampir Sempurna!',
  ],
  [
    'Yeay kamu hebat!',
    'Sepertinya Kamu mulai Hafal',
    'Bagus sekali!',
  ],
];

String winWords(int point) {
  List<String> potensialWord = [];
  const SCORE_TOLERANCE = SCORE_BASE / FAIL_TOLERANCE;
  if (point == SCORE_BASE) {
    potensialWord = words[3];
  } else if (point == SCORE_TOLERANCE * 2) {
    potensialWord = words[2];
  } else if (point == SCORE_TOLERANCE) {
    potensialWord = words[2];
  } else {
    potensialWord = words[1];
  }
  final int random = 0 + Random().nextInt(potensialWord.length - 0);
  return potensialWord[random];
}