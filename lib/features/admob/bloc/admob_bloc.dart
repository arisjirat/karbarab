import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:karbarab/utils/logger.dart';
import 'package:meta/meta.dart';

part 'admob_event.dart';
part 'admob_state.dart';

class AdmobBloc extends Bloc<AdmobEvent, AdmobState> {
  final UserRepository _userRepository = UserRepository();
  final CollectionReference adsRewardsCollection =
      Firestore.instance.collection('rewards');
  @override
  AdmobState get initialState => AdmobState.reset();

  @override
  Stream<AdmobState> mapEventToState(
    AdmobEvent event,
  ) async* {
    if (event is UserAdsrewards) {
      yield* _mapUserAdsrewards(
        event.adsMode,
        event.coin,
        quizId: event.quizId,
      );
    } else if (event is AdsClosed) {
      yield AdmobState.closedAds();
    } else if (event is AdsLoaded) {
      yield AdmobState.loaded();
    } else if (event is AdsFailedLoad) {
      yield AdmobState.loadedFailure();
    }
  }

  Stream<AdmobState> _mapUserAdsrewards(AdsMode adsMode, int coin, { quizId = '' }) async* {
    try {
      final UserModel user = await _userRepository.getUserMeta();
      await adsRewardsCollection.document().setData({
        'user': user.toJson(),
        'coin': coin.toString(),
        'quizId': quizId.toString(),
        'adsMode': adsMode.toString(),
        'createdAt': FieldValue.serverTimestamp()
      });
      yield AdmobState.rewarded();
    } catch (e) {
      Logger.e('Error Woi', s: StackTrace.current, e: e );
      yield AdmobState.closedAds();
    }
  }
}
