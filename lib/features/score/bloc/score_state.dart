part of 'score_bloc.dart';

@immutable
abstract class ScoreState extends Equatable {
  const ScoreState();

  @override
  List<Object> get props => [];
}

class ScoreAdded extends ScoreState {}

class SummaryUserScore extends ScoreState {
  final List<ScoreQuizModel> badQuiz;
  final List<ScoreQuizModel> goodQuiz;
  SummaryUserScore({ @required this.badQuiz, @required this.goodQuiz, });
}

class HasScore extends ScoreState {
  final double scoreGambarArab;
  final double scoreArabGambar;
  final double scoreArabKata;
  final double scoreKataArab;
  final bool loadScore;

  HasScore({
    @required this.scoreGambarArab,
    @required this.scoreArabGambar,
    @required this.scoreArabKata,
    @required this.scoreKataArab,
    @required this.loadScore,
  });

  HasScore copyWith({
    double scoreGambarArab,
    double scoreArabGambar,
    double scoreArabKata,
    double scoreKataArab,
    bool loadScore,
  }) {
    return HasScore(
      scoreGambarArab: scoreGambarArab ?? this.scoreGambarArab,
      scoreArabGambar: scoreArabGambar ?? this.scoreArabGambar,
      scoreArabKata: scoreArabKata ?? this.scoreArabKata,
      scoreKataArab: scoreKataArab ?? this.scoreKataArab,
      loadScore: loadScore ?? this.loadScore,
    );
  }

  @override
  List<Object> get props => [
    scoreArabGambar,
    scoreGambarArab,
    scoreArabKata,
    scoreKataArab,
    loadScore,
  ];

  @override
  String toString() => 'HasScore { $scoreArabGambar, $scoreGambarArab, $scoreArabKata, $scoreKataArab }';
}
