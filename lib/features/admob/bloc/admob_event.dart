part of 'admob_bloc.dart';

enum AdsMode { GlOBAL_SCORE, HINT }

@immutable
abstract class AdmobEvent extends Equatable {
  const AdmobEvent();

  @override
  List<Object> get props => [];
}

class AdsLoaded extends AdmobEvent {}

class AdsClosed extends AdmobEvent {}

class AdsFailedLoad extends AdmobEvent {}

class UserAdsrewards extends AdmobEvent {
  final AdsMode adsMode;
  final int coin;
  final String quizId;

  UserAdsrewards({
    @required this.adsMode,
    @required this.coin,
    this.quizId,
  });
}