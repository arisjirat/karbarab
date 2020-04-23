part of 'battle_list_bloc.dart';

abstract class BattleListState extends Equatable {
  const BattleListState();
}

class HasBattleList extends BattleListState {
  final bool isLoading;
  final bool isComplete;
  final List<Score> quizBattle;
  final User user;

  HasBattleList({
    @required this.quizBattle,
    @required this.isComplete,
    @required this.isLoading,
    this.user,
  });

  HasBattleList copyWith({
    List<Score> quizBattle,
    bool isLoading,
    bool isComplete,
    User user,
  }) {
    return HasBattleList(
      isLoading: isLoading ?? this.isLoading,
      isComplete: isComplete ?? this.isComplete,
      quizBattle: quizBattle ?? this.quizBattle,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
    quizBattle,
    isLoading,
    isComplete,
    user,
  ];

  @override
  String toString() => 'HasBattleList { $quizBattle, $isLoading, $isComplete, $user }';
}
