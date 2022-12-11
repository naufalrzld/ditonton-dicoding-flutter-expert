import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_watchlist_status.dart';
import '../../../domain/usecases/remove_watchlist.dart';
import '../../../domain/usecases/save_watchlist.dart';
import '../base_bloc_state.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getMovieRecommendations,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist
  ) : super(MovieDetailState.init()) {
    on<OnFetchDetailMovie>((event, emit) async {
      emit(state.copyWith(movieDetailState: Loading()));

      final result = await _getMovieDetail.execute(event.id);

      result.fold((failure) {
        emit(state.copyWith(movieDetailState: Error(failure.message)));
      }, (data) {
        emit(state.copyWith(movieDetailState: HasData(data)));
      });
    });

    on<OnFetchRecommendationMovie>((event, emit) async {
      emit(state.copyWith(movieRecommendationState: Loading()));

      final result = await _getMovieRecommendations.execute(event.id);

      result.fold((failure) {
        emit(state.copyWith(movieRecommendationState: Error(failure.message)));
      }, (data) {
        emit(state.copyWith(movieRecommendationState: HasData(data)));
      });
    });

    on<OnAddToWatchList>((event, emit) async {
      final result = await _saveWatchlist.execute(event.movie);

      result.fold((failure) async {
        emit(state.copyWith(watchListMessage: failure.message));
      }, (successMessage) async {
        emit(state.copyWith(watchListMessage: successMessage));
      });

      add(OnFetchWatchListStatus(event.movie.id));
    });

    on<OnRemoveFromWatchList>((event, emit) async {
      final result = await _removeWatchlist.execute(event.movie);

      result.fold((failure) async {
        emit(state.copyWith(watchListMessage: failure.message));
      }, (successMessage) async {
        emit(state.copyWith(watchListMessage: successMessage));
      });

      add(OnFetchWatchListStatus(event.movie.id));
    });

    on<OnFetchWatchListStatus>((event, emit) async {
      final result = await _getWatchListStatus.execute(event.id);
      emit(state.copyWith(
          watchListMessage: '',
          isAddedtoWatchlist: result
      ));
    });
  }
}
