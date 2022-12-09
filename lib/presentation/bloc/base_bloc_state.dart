import 'package:equatable/equatable.dart';

abstract class BaseBlocState<T> extends Equatable {
  const BaseBlocState();

  @override
  List<T> get props => [];
}

class Empty extends BaseBlocState {}

class Loading extends BaseBlocState {}

class Error extends BaseBlocState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData<T> extends BaseBlocState {
  final T result;

  HasData(this.result);

  @override
  List<T> get props => [result];
}