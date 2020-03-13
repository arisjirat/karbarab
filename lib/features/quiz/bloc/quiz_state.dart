part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class EmptyQuiz extends QuizState {}

class HasQuiz extends QuizState {
  final List<QuizModel> list;
  final QuizModel correct;

  HasQuiz({ @required this.list, @required this.correct });

  @override
  List<Object> get props => [list, correct];

  @override
  String toString() => 'HasQuiz { displayName: $list, avatar: $correct }';
}