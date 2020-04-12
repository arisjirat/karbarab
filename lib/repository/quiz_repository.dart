import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:karbarab/core/request/quiz.dart';
import 'package:karbarab/features/quiz/model/quiz.dart';


class Quiz {
  final List<QuizModel> list;
  final QuizModel correct;

  Quiz({ @required this.list, @required this.correct });
}

class QuizRepository {
  QuizRepository();

  List<QuizModel> allQuiz() {
    return getQuizData();
  }

  QuizModel getSingleQuiz(id) {
    try {
      final QuizModel quiz = allQuiz().where((e) => e.id == id).toList()[0];
      return quiz;
    } catch (e) {
      throw Exception('quiz not found');
    }
  }

  Quiz getQuiz(bool image) {
    List<QuizModel> listQuiz = getQuizData();
    if (image) {
      listQuiz = listQuiz.where((q) => q.image != '').toList();
    }
    listQuiz.shuffle();
    listQuiz = listQuiz.sublist(0, 4);
    final List<QuizModel> quizList = listQuiz.sublist(0, 4);
    final int random = 0 + Random().nextInt(listQuiz.length - 0);
    final QuizModel correct = listQuiz[random];
    return Quiz(list: quizList, correct: correct);
  }

}
