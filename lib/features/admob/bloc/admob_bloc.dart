import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:karbarab/features/auth/model/user_model.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'admob_event.dart';
part 'admob_state.dart';

class AdmobBloc extends Bloc<AdmobEvent, AdmobState> {
  final UserRepository _userRepository = UserRepository();
  final CollectionReference adsRewardsCollection =
      Firestore.instance.collection('rewards');
  @override
  AdmobState get initialState => null;

  @override
  Stream<AdmobState> mapEventToState(
    AdmobEvent event,
  ) async* {
    if (event is UserAdsrewards) {
      yield* _mapUserAdsrewards(
        event.adsMode,
        quizId: event.quizId,
      );
    }
  }

  Stream<AdmobState> _mapUserAdsrewards(adsMode, { quizId = '' }) async* {
    final UserModel user = await _userRepository.getUserMeta();
    try {
      await adsRewardsCollection.document().setData({
        'user': user.toJson(),
        'quizId': quizId,
        'adsMode': adsMode,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print('error submit user Rewards:');
      print(e);
    }
  }
}
