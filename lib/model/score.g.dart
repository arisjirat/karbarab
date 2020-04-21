// GENERATED CODE - DO NOT MODIFY BY HAND

part of score;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Score extends Score {
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool isBattle;
  @override
  final bool isSolved;
  @override
  final Quiz metaQuiz;
  @override
  final User metaUser;
  @override
  final String quizId;
  @override
  final GameMode quizMode;
  @override
  final double score;
  @override
  final String scoreId;
  @override
  final double targetScore;
  @override
  final String userId;
  @override
  final String userIdSender;
  @override
  final String userAvatarSender;
  @override
  final String usernameSender;
  @override
  final String userTokenSender;

  factory _$Score([void Function(ScoreBuilder) updates]) =>
      (new ScoreBuilder()..update(updates)).build();

  _$Score._(
      {this.createdAt,
      this.updatedAt,
      this.isBattle,
      this.isSolved,
      this.metaQuiz,
      this.metaUser,
      this.quizId,
      this.quizMode,
      this.score,
      this.scoreId,
      this.targetScore,
      this.userId,
      this.userIdSender,
      this.userAvatarSender,
      this.usernameSender,
      this.userTokenSender})
      : super._() {
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('Score', 'createdAt');
    }
    if (isBattle == null) {
      throw new BuiltValueNullFieldError('Score', 'isBattle');
    }
    if (isSolved == null) {
      throw new BuiltValueNullFieldError('Score', 'isSolved');
    }
    if (metaQuiz == null) {
      throw new BuiltValueNullFieldError('Score', 'metaQuiz');
    }
    if (metaUser == null) {
      throw new BuiltValueNullFieldError('Score', 'metaUser');
    }
    if (quizId == null) {
      throw new BuiltValueNullFieldError('Score', 'quizId');
    }
    if (quizMode == null) {
      throw new BuiltValueNullFieldError('Score', 'quizMode');
    }
    if (scoreId == null) {
      throw new BuiltValueNullFieldError('Score', 'scoreId');
    }
    if (userId == null) {
      throw new BuiltValueNullFieldError('Score', 'userId');
    }
  }

  @override
  Score rebuild(void Function(ScoreBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoreBuilder toBuilder() => new ScoreBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Score &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isBattle == other.isBattle &&
        isSolved == other.isSolved &&
        metaQuiz == other.metaQuiz &&
        metaUser == other.metaUser &&
        quizId == other.quizId &&
        quizMode == other.quizMode &&
        score == other.score &&
        scoreId == other.scoreId &&
        targetScore == other.targetScore &&
        userId == other.userId &&
        userIdSender == other.userIdSender &&
        userAvatarSender == other.userAvatarSender &&
        usernameSender == other.usernameSender &&
        userTokenSender == other.userTokenSender;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    0,
                                                                    createdAt
                                                                        .hashCode),
                                                                updatedAt
                                                                    .hashCode),
                                                            isBattle.hashCode),
                                                        isSolved.hashCode),
                                                    metaQuiz.hashCode),
                                                metaUser.hashCode),
                                            quizId.hashCode),
                                        quizMode.hashCode),
                                    score.hashCode),
                                scoreId.hashCode),
                            targetScore.hashCode),
                        userId.hashCode),
                    userIdSender.hashCode),
                userAvatarSender.hashCode),
            usernameSender.hashCode),
        userTokenSender.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Score')
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('isBattle', isBattle)
          ..add('isSolved', isSolved)
          ..add('metaQuiz', metaQuiz)
          ..add('metaUser', metaUser)
          ..add('quizId', quizId)
          ..add('quizMode', quizMode)
          ..add('score', score)
          ..add('scoreId', scoreId)
          ..add('targetScore', targetScore)
          ..add('userId', userId)
          ..add('userIdSender', userIdSender)
          ..add('userAvatarSender', userAvatarSender)
          ..add('usernameSender', usernameSender)
          ..add('userTokenSender', userTokenSender))
        .toString();
  }
}

class ScoreBuilder implements Builder<Score, ScoreBuilder> {
  _$Score _$v;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  bool _isBattle;
  bool get isBattle => _$this._isBattle;
  set isBattle(bool isBattle) => _$this._isBattle = isBattle;

  bool _isSolved;
  bool get isSolved => _$this._isSolved;
  set isSolved(bool isSolved) => _$this._isSolved = isSolved;

  QuizBuilder _metaQuiz;
  QuizBuilder get metaQuiz => _$this._metaQuiz ??= new QuizBuilder();
  set metaQuiz(QuizBuilder metaQuiz) => _$this._metaQuiz = metaQuiz;

  UserBuilder _metaUser;
  UserBuilder get metaUser => _$this._metaUser ??= new UserBuilder();
  set metaUser(UserBuilder metaUser) => _$this._metaUser = metaUser;

  String _quizId;
  String get quizId => _$this._quizId;
  set quizId(String quizId) => _$this._quizId = quizId;

  GameMode _quizMode;
  GameMode get quizMode => _$this._quizMode;
  set quizMode(GameMode quizMode) => _$this._quizMode = quizMode;

  double _score;
  double get score => _$this._score;
  set score(double score) => _$this._score = score;

  String _scoreId;
  String get scoreId => _$this._scoreId;
  set scoreId(String scoreId) => _$this._scoreId = scoreId;

  double _targetScore;
  double get targetScore => _$this._targetScore;
  set targetScore(double targetScore) => _$this._targetScore = targetScore;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _userIdSender;
  String get userIdSender => _$this._userIdSender;
  set userIdSender(String userIdSender) => _$this._userIdSender = userIdSender;

  String _userAvatarSender;
  String get userAvatarSender => _$this._userAvatarSender;
  set userAvatarSender(String userAvatarSender) =>
      _$this._userAvatarSender = userAvatarSender;

  String _usernameSender;
  String get usernameSender => _$this._usernameSender;
  set usernameSender(String usernameSender) =>
      _$this._usernameSender = usernameSender;

  String _userTokenSender;
  String get userTokenSender => _$this._userTokenSender;
  set userTokenSender(String userTokenSender) =>
      _$this._userTokenSender = userTokenSender;

  ScoreBuilder();

  ScoreBuilder get _$this {
    if (_$v != null) {
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _isBattle = _$v.isBattle;
      _isSolved = _$v.isSolved;
      _metaQuiz = _$v.metaQuiz?.toBuilder();
      _metaUser = _$v.metaUser?.toBuilder();
      _quizId = _$v.quizId;
      _quizMode = _$v.quizMode;
      _score = _$v.score;
      _scoreId = _$v.scoreId;
      _targetScore = _$v.targetScore;
      _userId = _$v.userId;
      _userIdSender = _$v.userIdSender;
      _userAvatarSender = _$v.userAvatarSender;
      _usernameSender = _$v.usernameSender;
      _userTokenSender = _$v.userTokenSender;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Score other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Score;
  }

  @override
  void update(void Function(ScoreBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Score build() {
    _$Score _$result;
    try {
      _$result = _$v ??
          new _$Score._(
              createdAt: createdAt,
              updatedAt: updatedAt,
              isBattle: isBattle,
              isSolved: isSolved,
              metaQuiz: metaQuiz.build(),
              metaUser: metaUser.build(),
              quizId: quizId,
              quizMode: quizMode,
              score: score,
              scoreId: scoreId,
              targetScore: targetScore,
              userId: userId,
              userIdSender: userIdSender,
              userAvatarSender: userAvatarSender,
              usernameSender: usernameSender,
              userTokenSender: userTokenSender);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'metaQuiz';
        metaQuiz.build();
        _$failedField = 'metaUser';
        metaUser.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Score', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
