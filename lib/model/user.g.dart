// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final String id;
  @override
  final String avatar;
  @override
  final String email;
  @override
  final String fullname;
  @override
  final bool isGoogleAuth;
  @override
  final String password;
  @override
  final String tokenFCM;
  @override
  final String username;

  factory _$User([void Function(UserBuilder) updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.id,
      this.avatar,
      this.email,
      this.fullname,
      this.isGoogleAuth,
      this.password,
      this.tokenFCM,
      this.username})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('User', 'id');
    }
    if (isGoogleAuth == null) {
      throw new BuiltValueNullFieldError('User', 'isGoogleAuth');
    }
    if (tokenFCM == null) {
      throw new BuiltValueNullFieldError('User', 'tokenFCM');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('User', 'username');
    }
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        avatar == other.avatar &&
        email == other.email &&
        fullname == other.fullname &&
        isGoogleAuth == other.isGoogleAuth &&
        password == other.password &&
        tokenFCM == other.tokenFCM &&
        username == other.username;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), avatar.hashCode),
                            email.hashCode),
                        fullname.hashCode),
                    isGoogleAuth.hashCode),
                password.hashCode),
            tokenFCM.hashCode),
        username.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('avatar', avatar)
          ..add('email', email)
          ..add('fullname', fullname)
          ..add('isGoogleAuth', isGoogleAuth)
          ..add('password', password)
          ..add('tokenFCM', tokenFCM)
          ..add('username', username))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _avatar;
  String get avatar => _$this._avatar;
  set avatar(String avatar) => _$this._avatar = avatar;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _fullname;
  String get fullname => _$this._fullname;
  set fullname(String fullname) => _$this._fullname = fullname;

  bool _isGoogleAuth;
  bool get isGoogleAuth => _$this._isGoogleAuth;
  set isGoogleAuth(bool isGoogleAuth) => _$this._isGoogleAuth = isGoogleAuth;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _tokenFCM;
  String get tokenFCM => _$this._tokenFCM;
  set tokenFCM(String tokenFCM) => _$this._tokenFCM = tokenFCM;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _avatar = _$v.avatar;
      _email = _$v.email;
      _fullname = _$v.fullname;
      _isGoogleAuth = _$v.isGoogleAuth;
      _password = _$v.password;
      _tokenFCM = _$v.tokenFCM;
      _username = _$v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            id: id,
            avatar: avatar,
            email: email,
            fullname: fullname,
            isGoogleAuth: isGoogleAuth,
            password: password,
            tokenFCM: tokenFCM,
            username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
