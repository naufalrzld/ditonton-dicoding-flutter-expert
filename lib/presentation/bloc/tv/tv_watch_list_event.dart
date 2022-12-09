part of 'tv_watch_list_bloc.dart';

abstract class TvWatchListEvent extends Equatable {
  const TvWatchListEvent();

  @override
  List<Object> get props => [];
}

class OnFetchWatchListTv extends TvWatchListEvent {}
