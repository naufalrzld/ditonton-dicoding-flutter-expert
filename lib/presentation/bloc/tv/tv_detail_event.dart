part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchDetailTv extends TvDetailEvent {
  final int id;

  OnFetchDetailTv(this.id);

  @override
  List<Object> get props => [id];
}

class OnFetchRecommendationTv extends TvDetailEvent {
  final int id;

  OnFetchRecommendationTv(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddToWatchList extends TvDetailEvent {
  final TvDetail tv;

  OnAddToWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class OnRemoveFromWatchList extends TvDetailEvent {
  final TvDetail tv;

  OnRemoveFromWatchList(this.tv);

  @override
  List<Object> get props => [tv];
}

class OnFetchWatchListStatus extends TvDetailEvent {
  final int id;

  OnFetchWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}
