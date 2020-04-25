// GENERATED CODE - DO NOT MODIFY BY HAND

part of notification_queue;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationQueue extends NotificationQueue {
  @override
  final String id;
  @override
  final int timeMicro;
  @override
  final String scoreId;
  @override
  final String userIdSender;
  @override
  final String quizId;
  @override
  final double targetScore;
  @override
  final String usernameSender;
  @override
  final String title;
  @override
  final String message;
  @override
  final ActionTypeNotification actionNotificationType;

  factory _$NotificationQueue(
          [void Function(NotificationQueueBuilder) updates]) =>
      (new NotificationQueueBuilder()..update(updates)).build();

  _$NotificationQueue._(
      {this.id,
      this.timeMicro,
      this.scoreId,
      this.userIdSender,
      this.quizId,
      this.targetScore,
      this.usernameSender,
      this.title,
      this.message,
      this.actionNotificationType})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'id');
    }
    if (timeMicro == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'timeMicro');
    }
    if (scoreId == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'scoreId');
    }
    if (userIdSender == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'userIdSender');
    }
    if (quizId == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'quizId');
    }
    if (targetScore == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'targetScore');
    }
    if (usernameSender == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'usernameSender');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'title');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('NotificationQueue', 'message');
    }
    if (actionNotificationType == null) {
      throw new BuiltValueNullFieldError(
          'NotificationQueue', 'actionNotificationType');
    }
  }

  @override
  NotificationQueue rebuild(void Function(NotificationQueueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationQueueBuilder toBuilder() =>
      new NotificationQueueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationQueue &&
        id == other.id &&
        timeMicro == other.timeMicro &&
        scoreId == other.scoreId &&
        userIdSender == other.userIdSender &&
        quizId == other.quizId &&
        targetScore == other.targetScore &&
        usernameSender == other.usernameSender &&
        title == other.title &&
        message == other.message &&
        actionNotificationType == other.actionNotificationType;
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
                                    $jc($jc(0, id.hashCode),
                                        timeMicro.hashCode),
                                    scoreId.hashCode),
                                userIdSender.hashCode),
                            quizId.hashCode),
                        targetScore.hashCode),
                    usernameSender.hashCode),
                title.hashCode),
            message.hashCode),
        actionNotificationType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NotificationQueue')
          ..add('id', id)
          ..add('timeMicro', timeMicro)
          ..add('scoreId', scoreId)
          ..add('userIdSender', userIdSender)
          ..add('quizId', quizId)
          ..add('targetScore', targetScore)
          ..add('usernameSender', usernameSender)
          ..add('title', title)
          ..add('message', message)
          ..add('actionNotificationType', actionNotificationType))
        .toString();
  }
}

class NotificationQueueBuilder
    implements Builder<NotificationQueue, NotificationQueueBuilder> {
  _$NotificationQueue _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  int _timeMicro;
  int get timeMicro => _$this._timeMicro;
  set timeMicro(int timeMicro) => _$this._timeMicro = timeMicro;

  String _scoreId;
  String get scoreId => _$this._scoreId;
  set scoreId(String scoreId) => _$this._scoreId = scoreId;

  String _userIdSender;
  String get userIdSender => _$this._userIdSender;
  set userIdSender(String userIdSender) => _$this._userIdSender = userIdSender;

  String _quizId;
  String get quizId => _$this._quizId;
  set quizId(String quizId) => _$this._quizId = quizId;

  double _targetScore;
  double get targetScore => _$this._targetScore;
  set targetScore(double targetScore) => _$this._targetScore = targetScore;

  String _usernameSender;
  String get usernameSender => _$this._usernameSender;
  set usernameSender(String usernameSender) =>
      _$this._usernameSender = usernameSender;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ActionTypeNotification _actionNotificationType;
  ActionTypeNotification get actionNotificationType =>
      _$this._actionNotificationType;
  set actionNotificationType(ActionTypeNotification actionNotificationType) =>
      _$this._actionNotificationType = actionNotificationType;

  NotificationQueueBuilder();

  NotificationQueueBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _timeMicro = _$v.timeMicro;
      _scoreId = _$v.scoreId;
      _userIdSender = _$v.userIdSender;
      _quizId = _$v.quizId;
      _targetScore = _$v.targetScore;
      _usernameSender = _$v.usernameSender;
      _title = _$v.title;
      _message = _$v.message;
      _actionNotificationType = _$v.actionNotificationType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationQueue other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NotificationQueue;
  }

  @override
  void update(void Function(NotificationQueueBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NotificationQueue build() {
    final _$result = _$v ??
        new _$NotificationQueue._(
            id: id,
            timeMicro: timeMicro,
            scoreId: scoreId,
            userIdSender: userIdSender,
            quizId: quizId,
            targetScore: targetScore,
            usernameSender: usernameSender,
            title: title,
            message: message,
            actionNotificationType: actionNotificationType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
