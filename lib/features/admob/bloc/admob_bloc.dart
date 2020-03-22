import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admob_event.dart';
part 'admob_state.dart';

class AdmobBloc extends Bloc<AdmobEvent, AdmobState> {
  @override
  AdmobState get initialState => AdmobInitial();

  @override
  Stream<AdmobState> mapEventToState(
    AdmobEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
