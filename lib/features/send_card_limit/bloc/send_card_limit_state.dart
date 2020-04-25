part of 'send_card_limit_bloc.dart';

abstract class SendCardLimitState extends Equatable {
  const SendCardLimitState();
}

class SendCardLimitInitial extends SendCardLimitState {
  final int limit;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  SendCardLimitInitial({
    @required this.limit,
    @required this.isLoading,
    @required this.isFailure,
    @required this.isSuccess,
  });
  @override
  List<Object> get props => [
    isLoading,
    isFailure,
    isSuccess,
    limit,
  ];
}

class HasSendCardLimit extends SendCardLimitState {
  final int limit;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  HasSendCardLimit({
    @required this.limit,
    @required this.isLoading,
    @required this.isFailure,
    @required this.isSuccess,
  });

  HasSendCardLimit copyWith({
    int limit,
    bool isLoading,
    bool isSuccess,
    bool isFailure,
  }) {
    return HasSendCardLimit(
      limit: limit ?? this.limit,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object> get props => [
    isLoading,
    isFailure,
    isSuccess,
    limit,
  ];
  @override
  String toString() => 'HasSendCardLimit { $isLoading, $isFailure, $isSuccess, $limit }';
}

