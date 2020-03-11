import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(
    CounterEvent event,
  ) async* {
    if (event is Increment) {
      yield* _mapIncrementToState();
    } else if (event is Decrement) {
      yield* _mapDecrementToState();
    }
  }

  Stream<int> _mapIncrementToState() async* {
    yield state + 1;
  }
  Stream<int> _mapDecrementToState() async* {
    yield state - 1;
  }
}
