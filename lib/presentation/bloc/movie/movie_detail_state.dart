part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final BaseBlocState movieDetailState;
  final BaseBlocState movieRecommendationState;
  final bool isAddedToWatchlist;
  final String watchListMessage;

  MovieDetailState({
    required this.movieDetailState,
    required this.movieRecommendationState,
    required this.isAddedToWatchlist,
    required this.watchListMessage,
  });

  MovieDetailState copyWith({
    BaseBlocState? movieDetailState,
    BaseBlocState? movieRecommendationState,
    bool? isAddedtoWatchlist,
    String? watchListMessage,
  }) => MovieDetailState(
    movieDetailState: movieDetailState ?? this.movieDetailState,
    movieRecommendationState: movieRecommendationState ?? this.movieRecommendationState,
    isAddedToWatchlist: isAddedtoWatchlist ?? this.isAddedToWatchlist,
    watchListMessage: watchListMessage ?? this.watchListMessage,
  );

  factory MovieDetailState.init() => MovieDetailState(
    movieDetailState: Empty(),
    movieRecommendationState: Empty(),
    isAddedToWatchlist: false,
    watchListMessage: ''
  );

  @override
  List<Object?> get props => [
    movieDetailState,
    movieRecommendationState,
    isAddedToWatchlist,
    watchListMessage
  ];
}
