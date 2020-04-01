part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class EmptyQuiz extends QuizState {}

class AllQuiz extends QuizState {
  final List<QuizModel> list;

  AllQuiz(this.list);
  @override
  List<Object> get props => [list];

  @override
  String toString() => 'AllQuiz { list: $list,';
  
}

class HasQuiz extends QuizState {
  final List<QuizModel> list;
  final QuizModel correct;

  HasQuiz({ @required this.list, @required this.correct });

  @override
  List<Object> get props => [list, correct];

  @override
  String toString() => 'HasQuiz { list: $list, correct: $correct }';
}