part of 'feedback_bloc.dart';

@immutable
class FeedbackState {
  final bool isSuccess;
  final bool isLoading;
  final bool isFailure;

  FeedbackState({
    @required this.isSuccess,
    @required this.isLoading,
    @required this.isFailure,
  });

  factory FeedbackState.empty() {
    return FeedbackState(
      isSuccess: false,
      isFailure: false,
      isLoading: false,
    );
  }

  factory FeedbackState.loading() {
    return FeedbackState(
      isSuccess: false,
      isFailure: false,
      isLoading: true,
    );
  }

  factory FeedbackState.failure() {
    return FeedbackState(
      isSuccess: false,
      isFailure: true,
      isLoading: false,
    );
  }

  factory FeedbackState.success() {
    return FeedbackState(
      isSuccess: true,
      isFailure: false,
      isLoading: false,
    );
  }

  @override
  String toString() {
    return '''FeedbackState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isLoading: $isLoading,
    }''';
  }
}
