part of 'quiz_bloc.dart';

@immutable
class QuizState {
  final bool isCorrect;
  final bool played;

  QuizState({
    @required this.isCorrect,
    @required this.played,
  });

  factory QuizState.empty() {
    return QuizState(
      isCorrect: false,
      played: false,
    );
  }

  factory QuizState.inCorrect() {
    return QuizState(
      isCorrect: false,
      played: true,
    );
  }

  factory QuizState.correct() {
    return QuizState(
      isCorrect: true,
      played: true,
    );
  }

  QuizState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isCorrect: false,
      played: false,
    );
  }

  QuizState copyWith({
    bool isCorrect,
    bool played,
  }) {
    return QuizState(
      isCorrect: isCorrect ?? this.isCorrect,
      played: played ?? this.played,
    );
  }

  @override
  String toString() {
    return '''QuizState {
      isCorrect: $isCorrect,
      played: $played,
    }''';
  }
}