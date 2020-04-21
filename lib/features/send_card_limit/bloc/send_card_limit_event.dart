part of 'send_card_limit_bloc.dart';

abstract class SendCardLimitEvent extends Equatable {
  const SendCardLimitEvent();

  @override
  List<Object> get props => [];
}

class GetSendCardLimit extends SendCardLimitEvent {}

class AddSendCardLimit extends SendCardLimitEvent {}

class DecreaseSendCardLimit extends SendCardLimitEvent {}
