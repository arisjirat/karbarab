import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  @override
  NotificationState get initialState => NotificationInitial();

  @override
  void initState() {
    // super.initState();
    
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
