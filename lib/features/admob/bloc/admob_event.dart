part of 'admob_bloc.dart';

@immutable
abstract class AdmobEvent extends Equatable {
  const AdmobEvent();

  @override
  List<Object> get props => [];
}

class GetSummaryUserQuizScore extends AdmobEvent {}

class UserAdsrewards extends AdmobEvent {
  
  final String adsMode;
  final String quizId;

  UserAdsrewards({
    @required this.adsMode,
    this.quizId,
  });
}