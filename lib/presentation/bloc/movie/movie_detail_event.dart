part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnFetchDetailMovie extends MovieDetailEvent {
  final int id;

  OnFetchDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}

class OnFetchRecommendationMovie extends MovieDetailEvent {
  final int id;

  OnFetchRecommendationMovie(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddToWatchList extends MovieDetailEvent {
  final MovieDetail movie;

  OnAddToWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveFromWatchList extends MovieDetailEvent {
  final MovieDetail movie;

  OnRemoveFromWatchList(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnFetchWatchListStatus extends MovieDetailEvent {
  final int id;

  OnFetchWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
