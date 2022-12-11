part of 'movie_watch_list_bloc.dart';

abstract class MovieWatchListEvent extends Equatable {
  const MovieWatchListEvent();

  @override
  List<Object?> get props => [];
}

class OnFetchWatchListMovie extends MovieWatchListEvent {}
