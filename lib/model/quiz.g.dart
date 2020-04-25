// GENERATED CODE - DO NOT MODIFY BY HAND

part of quiz;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Quiz extends Quiz {
  @override
  final String id;
  @override
  final String arab;
  @override
  final String bahasa;
  @override
  final String image;
  @override
  final String voice;
  @override
  final CardCategory cardCategory;
  @override
  final int level;
  @override
  final DateTime date;

  factory _$Quiz([void Function(QuizBuilder) updates]) =>
      (new QuizBuilder()..update(updates)).build();

  _$Quiz._(
      {this.id,
      this.arab,
      this.bahasa,
      this.image,
      this.voice,
      this.cardCategory,
      this.level,
      this.date})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Quiz', 'id');
    }
    if (arab == null) {
      throw new BuiltValueNullFieldError('Quiz', 'arab');
    }
    if (bahasa == null) {
      throw new BuiltValueNullFieldError('Quiz', 'bahasa');
    }
    if (cardCategory == null) {
      throw new BuiltValueNullFieldError('Quiz', 'cardCategory');
    }
    if (level == null) {
      throw new BuiltValueNullFieldError('Quiz', 'level');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('Quiz', 'date');
    }
  }

  @override
  Quiz rebuild(void Function(QuizBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QuizBuilder toBuilder() => new QuizBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Quiz &&
        id == other.id &&
        arab == other.arab &&
        bahasa == other.bahasa &&
        image == other.image &&
        voice == other.voice &&
        cardCategory == other.cardCategory &&
        level == other.level &&
        date == other.date;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), arab.hashCode),
                            bahasa.hashCode),
                        image.hashCode),
                    voice.hashCode),
                cardCategory.hashCode),
            level.hashCode),
        date.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Quiz')
          ..add('id', id)
          ..add('arab', arab)
          ..add('bahasa', bahasa)
          ..add('image', image)
          ..add('voice', voice)
          ..add('cardCategory', cardCategory)
          ..add('level', level)
          ..add('date', date))
        .toString();
  }
}

class QuizBuilder implements Builder<Quiz, QuizBuilder> {
  _$Quiz _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _arab;
  String get arab => _$this._arab;
  set arab(String arab) => _$this._arab = arab;

  String _bahasa;
  String get bahasa => _$this._bahasa;
  set bahasa(String bahasa) => _$this._bahasa = bahasa;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  String _voice;
  String get voice => _$this._voice;
  set voice(String voice) => _$this._voice = voice;

  CardCategory _cardCategory;
  CardCategory get cardCategory => _$this._cardCategory;
  set cardCategory(CardCategory cardCategory) =>
      _$this._cardCategory = cardCategory;

  int _level;
  int get level => _$this._level;
  set level(int level) => _$this._level = level;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  QuizBuilder();

  QuizBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _arab = _$v.arab;
      _bahasa = _$v.bahasa;
      _image = _$v.image;
      _voice = _$v.voice;
      _cardCategory = _$v.cardCategory;
      _level = _$v.level;
      _date = _$v.date;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Quiz other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Quiz;
  }

  @override
  void update(void Function(QuizBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Quiz build() {
    final _$result = _$v ??
        new _$Quiz._(
            id: id,
            arab: arab,
            bahasa: bahasa,
            image: image,
            voice: voice,
            cardCategory: cardCategory,
            level: level,
            date: date);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
