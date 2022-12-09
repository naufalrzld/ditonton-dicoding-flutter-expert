part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  final BaseBlocState tvDetailState;
  final BaseBlocState tvRecommendationState;
  final bool isAddedtoWatchlist;
  final String watchListMessage;

  TvDetailState({
    required this.tvDetailState,
    required this.tvRecommendationState,
    required this.isAddedtoWatchlist,
    required this.watchListMessage,
  });

  TvDetailState copyWith({
    BaseBlocState? tvDetailState,
    BaseBlocState? tvRecommendationState,
    bool? isAddedtoWatchlist,
    String? watchListMessage,
  }) => TvDetailState(
    tvDetailState: tvDetailState ?? this.tvDetailState,
    tvRecommendationState: tvRecommendationState ?? this.tvRecommendationState,
    isAddedtoWatchlist: isAddedtoWatchlist ?? this.isAddedtoWatchlist,
    watchListMessage: watchListMessage ?? this.watchListMessage,
  );

  factory TvDetailState.init() => TvDetailState(
    tvDetailState: Empty(),
    tvRecommendationState: Empty(),
    isAddedtoWatchlist: false,
    watchListMessage: ''
  );

  @override
  List<Object?> get props => [
    tvDetailState,
    tvRecommendationState,
    isAddedtoWatchlist,
    watchListMessage
  ];
}
