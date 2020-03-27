part of 'voices_bloc.dart';

abstract class VoicesState extends Equatable {
  const VoicesState();
}

class VoicesInitial extends VoicesState {
  @override
  List<Object> get props => [];
}

class HasSpeech extends VoicesState {
  final String id;
  final String path;
  HasSpeech({ @required this.id, @required this.path});

  @override
  List<Object> get props => [
    id,
    path,
  ];

  @override
  String toString() => 'HasSpeech { $id, $path, }';
}
