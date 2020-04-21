part of 'battle_list_bloc.dart';

abstract class BattleListState extends Equatable {
  const BattleListState();
}

class HasBattleList extends BattleListState {
  final bool isLoading;
  final bool isComplete;
  final List<Score> quizBattle;

  HasBattleList({
    @required this.quizBattle,
    @required this.isComplete,
    @required this.isLoading,
  });

  HasBattleList copyWith({
    List<Score> quizBattle,
    bool isLoading,
    bool isComplete,
  }) {
    return HasBattleList(
      isLoading: isLoading ?? this.isLoading,
      isComplete: isComplete ?? this.isComplete,
      quizBattle: quizBattle ?? this.quizBattle,
    );
  }

  @override
  List<Object> get props => [
    quizBattle,
    isLoading,
    isComplete,
  ];

  @override
  String toString() => 'HasBattleList { $quizBattle, $isLoading, $isComplete }';
}
