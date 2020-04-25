import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:karbarab/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'send_card_limit_event.dart';
part 'send_card_limit_state.dart';

class SendCardLimitBloc extends Bloc<SendCardLimitEvent, SendCardLimitState> {
  final UserRepository _userRepository = UserRepository();

  @override
  SendCardLimitState get initialState => HasSendCardLimit(
    isFailure: false,
    isLoading: false,
    isSuccess: false,
    limit: 0
  );

  @override
  Stream<SendCardLimitState> mapEventToState(
    SendCardLimitEvent event,
  ) async* {
    if (event is GetSendCardLimit) {
      yield* _mapGetLimitToState();
    } else if (event is AddSendCardLimit) {
      yield* _mapAddLimitToState();
    }
  }
  Stream<SendCardLimitState> _mapAddLimitToState() async* {
    final HasSendCardLimit currentState = state as HasSendCardLimit;
    yield HasSendCardLimit(
      isFailure: false,
      isLoading: true,
      isSuccess: false,
      limit: currentState.limit,
    );
    final limit = await _userRepository.addSendCardLimit();
    yield HasSendCardLimit(
      isFailure: false,
      isLoading: false,
      isSuccess: false,
      limit: limit,
    );
  }

  Stream<SendCardLimitState> _mapGetLimitToState() async* {
    final HasSendCardLimit currentState = state as HasSendCardLimit;
    yield HasSendCardLimit(
      isFailure: false,
      isLoading: true,
      isSuccess: false,
      limit: currentState.limit
    );
    final limit = await _userRepository.getUserSendCardLimit();
    yield HasSendCardLimit(
      isFailure: false,
      isLoading: false,
      isSuccess: false,
      limit: limit,
    );
  }

}
