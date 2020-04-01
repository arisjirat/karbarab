part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class Initialize extends QuizEvent {}

class GetQuiz extends QuizEvent {
  final bool image;
  GetQuiz({ this.image = true });
}

class GetAllQuiz extends QuizEvent {}

class DestroyQuiz extends QuizEvent {}
