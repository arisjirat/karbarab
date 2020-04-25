part of 'admob_bloc.dart';

@immutable
class AdmobState {
  final bool isClosed;
  final bool isRewarded;
  final bool isRewardedLoaded;
  final bool isRewardedFailLoaded;
  final AdsMode adsMode;
  final bool isFailure;

  AdmobState({
    @required this.isClosed,
    @required this.isRewardedLoaded,
    @required this.isRewarded,
    @required this.isRewardedFailLoaded,
    this.adsMode,
    @required this.isFailure,
  });

  factory AdmobState.reset() {
    return AdmobState(
      isClosed: false,
      isFailure: false,
      isRewarded: false,
      isRewardedLoaded: false,
      isRewardedFailLoaded: false,
    );
  }

  factory AdmobState.closedAds() {
    return AdmobState(
      isClosed: true,
      isFailure: false,
      isRewarded: false,
      isRewardedLoaded: false,
      isRewardedFailLoaded: false,
    );
  }

  factory AdmobState.loaded() {
    return AdmobState(
      isClosed: false,
      isFailure: false,
      isRewardedLoaded: true,
      isRewarded: false,
      isRewardedFailLoaded: false,
    );
  }

    factory AdmobState.rewarded() {
    return AdmobState(
      isClosed: false,
      isFailure: false,
      isRewardedLoaded: false,
      isRewarded: true,
      isRewardedFailLoaded: false,
    );
  }

  factory AdmobState.loadedFailure() {
    return AdmobState(
      isClosed: false,
      isFailure: true,
      isRewarded: false,
      isRewardedLoaded: false,
      isRewardedFailLoaded: true,
    );
  }

  @override
  String toString() {
    return '''AdmobState {
      isClosed: $isClosed,
      isRewards: $isRewarded,
      isFailure: $isFailure,
      isRewardedLoaded: $isRewardedLoaded,
      isRewardedFailLoaded: $isRewardedFailLoaded,
    }''';
  }
}

