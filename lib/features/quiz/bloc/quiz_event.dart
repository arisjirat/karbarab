part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class Answer extends QuizEvent {}

class ResetAnswer extends QuizEvent {}
