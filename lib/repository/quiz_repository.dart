import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karbarab/core/request/quiz.dart';
import 'package:karbarab/model/quiz.dart';
import 'package:karbarab/model/score.dart';
import 'package:meta/meta.dart';


class ListQuiz {
  final List<Quiz> list;
  final Quiz correct;

  ListQuiz({ @required this.list, @required this.correct });
}

class QuizRepository {
  static const ID = 'id';
  static const ARAB = 'arab';
  static const BAHASA = 'bahasa';
  static const IMAGE = 'image';
  static const VOICE = 'voice';
  static const CARD_CATEGORY = 'cardCategory';
  static const LEVEL = 'level';
  static const DATE = 'date';

  static Quiz fromDoc(DocumentSnapshot document) {
    return Quiz(
      (u) => u
        ..id = document[ID]
        ..arab = document[ARAB]
        ..bahasa = document[BAHASA]
        ..image = document[IMAGE]
        ..voice = document[VOICE]
        ..cardCategory = CardCategoryHelper.valueOf(document[CARD_CATEGORY])
        ..level = document[LEVEL]
        ..date = document[DATE]
    );
  }

  static Quiz fromJson(Map<String, dynamic> json) {
    return Quiz(
      (u) => u
        ..id = json[ID]
        ..arab = json[ARAB]
        ..bahasa = json[BAHASA]
        ..image = json[IMAGE]
        ..voice = json[VOICE]
        ..cardCategory = CardCategoryHelper.valueOf(json[CARD_CATEGORY])
        ..level = json[LEVEL]
        ..date = DateTime.fromMicrosecondsSinceEpoch((json[DATE] as Timestamp).nanoseconds)
    );
  }

  static Map<String, dynamic> toMap(Quiz quiz) {
    return {
      ID: quiz.id,
      ARAB: quiz.arab,
      BAHASA: quiz.bahasa,
      IMAGE: quiz.image,
      VOICE: quiz.voice,
      CARD_CATEGORY: CardCategoryHelper.stringOf(quiz.cardCategory),
      LEVEL: quiz.level,
      DATE: quiz.date,
    };
  }

  QuizRepository();

  List<Quiz> allQuiz() {
    return getQuizData();
  }

  Quiz getSingleQuiz(id) {
    try {
      final Quiz quiz = allQuiz().firstWhere((e) => e.id == id);
      return quiz;
    } catch (e) {
      throw Exception('quiz not found');
    }
  }

  ListQuiz getQuiz(bool image) {
    List<Quiz> listQuiz = getQuizData();
    if (image) {
      listQuiz = listQuiz.where((q) => !(q.image == '' || q.image == null)).toList();
    }
    listQuiz.shuffle();
    listQuiz = listQuiz.sublist(0, 4);
    final List<Quiz> quizList = listQuiz.sublist(0, 4);
    final int random = 0 + Random().nextInt(listQuiz.length - 0);
    final Quiz correct = listQuiz[random];
    return ListQuiz(
      list: quizList,
      correct: correct
    );
  }

  ListQuiz getBattleQuiz(Score score) {
    List<Quiz> listQuiz = getQuizData();
    final isImageQuiz = score.quizMode == GameMode.ArabGambar || score.quizMode == GameMode.GambarArab;
    if (isImageQuiz) {
      listQuiz = listQuiz.where((q) => !(q.image == '' || q.image == null)).toList();
    }
    listQuiz.removeWhere((q) => score.quizId == q.id);
    listQuiz.shuffle();
    listQuiz = listQuiz.sublist(0, 3);
    listQuiz.add(score.metaQuiz);
    listQuiz.shuffle();
    return ListQuiz(
      list: listQuiz,
      correct: score.metaQuiz
    );
  }

}
