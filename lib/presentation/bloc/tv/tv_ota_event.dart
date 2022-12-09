part of 'tv_ota_bloc.dart';

abstract class TvOtaEvent extends Equatable {
  const TvOtaEvent();

  @override
  List<Object> get props => [];
}

class OnFetchOta extends TvOtaEvent {}
