part of 'voices_bloc.dart';

abstract class VoicesEvent extends Equatable {
  const VoicesEvent();

  @override
  List<Object> get props => [];
}

class GetSpeech extends VoicesEvent {
  final String quizId;
  final String arab;
  GetSpeech(this.quizId, this.arab);
}

class StopSpeech extends VoicesEvent {}
