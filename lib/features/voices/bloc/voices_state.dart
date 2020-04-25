part of 'voices_bloc.dart';

@immutable
class VoicesState {
  final bool isSuccess;
  final bool isLoading;
  final String id;
  final String path;
  final bool isFailure;

  VoicesState({
    @required this.isSuccess,
    @required this.isLoading,
    @required this.id,
    @required this.path,
    @required this.isFailure,
  });

  factory VoicesState.empty() {
    return VoicesState(
      isSuccess: false,
      isFailure: false,
      id: null,
      path: null,
      isLoading: false,
    );
  }

  factory VoicesState.loading() {
    return VoicesState(
      isSuccess: false,
      id: null,
      path: null,
      isFailure: false,
      isLoading: true,
    );
  }

  factory VoicesState.failure() {
    return VoicesState(
      isSuccess: false,
      isFailure: true,
      id: null,
      path: null,
      isLoading: false,
    );
  }

  factory VoicesState.success(id, path) {
    return VoicesState(
      isSuccess: true,
      id: id,
      path: path,
      isFailure: false,
      isLoading: false,
    );
  }

  @override
  String toString() {
    return '''VoicesState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isLoading: $isLoading,
    }''';
  }
}

