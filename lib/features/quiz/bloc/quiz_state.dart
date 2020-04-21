part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class EmptyQuiz extends QuizState {}

class AllQuiz extends QuizState {
  final List<Quiz> list;

  AllQuiz(this.list);
  @override
  List<Object> get props => [list];

  @override
  String toString() => 'AllQuiz { list: $list,';
  
}

class AllGoodQuiz extends QuizState {
  final bool isLoading;
  final bool isSuccess;
  final List<Quiz> list;

  AllGoodQuiz({ @required this.list, @required this.isLoading, @required this.isSuccess });

  @override
  List<Object> get props => [
    list,
    isLoading,
    isSuccess,
  ];

  @override
  String toString() => 'AllGoodQuiz { list: $list, $isLoading, $isSuccess';
  
}

class HasQuiz extends QuizState {
  final List<Quiz> list;
  final Quiz correct;

  HasQuiz({ @required this.list, @required this.correct });

  @override
  List<Object> get props => [list, correct];

  @override
  String toString() => 'HasQuiz { list: $list, correct: $correct }';
}