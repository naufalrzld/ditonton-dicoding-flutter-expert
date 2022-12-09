import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv_detail.dart';
import '../../../domain/usecases/tv_use_case.dart';
import '../base_bloc_state.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final TvUseCase _useCase;

  TvDetailBloc(this._useCase) : super(TvDetailState.init()) {
    on<OnFetchDetailTv>((event, emit) async {
      emit(state.copyWith(tvDetailState: Loading()));

      final result = await _useCase.getDetailTvShow(event.id);

      result.fold((failure) {
        emit(state.copyWith(tvDetailState: Error(failure.message)));
      }, (data) {
        emit(state.copyWith(tvDetailState: HasData(data)));
      });
    });

    on<OnFetchRecommendationTv>((event, emit) async {
      emit(state.copyWith(tvRecommendationState: Loading()));

      final result = await _useCase.getTvShowRecommendations(event.id);

      result.fold((failure) {
        emit(state.copyWith(tvRecommendationState: Error(failure.message)));
      }, (data) {
        emit(state.copyWith(tvRecommendationState: HasData(data)));
      });
    });

    on<OnAddToWatchList>((event, emit) async {
      final result = await _useCase.saveWatchList(event.tv);

      result.fold((failure) async {
        emit(state.copyWith(watchListMessage: failure.message));
      }, (successMessage) async {
        emit(state.copyWith(watchListMessage: successMessage));
      });

      add(OnFetchWatchListStatus(event.tv.id));
    });

    on<OnRemoveFromWatchList>((event, emit) async {
      final result = await _useCase.removeWatchlist(event.tv);

      result.fold((failure) async {
        emit(state.copyWith(watchListMessage: failure.message));
      }, (successMessage) async {
        emit(state.copyWith(watchListMessage: successMessage));
      });

      add(OnFetchWatchListStatus(event.tv.id));
    });

    on<OnFetchWatchListStatus>((event, emit) async {
      final result = await _useCase.isAddedToWatchlist(event.id);
      emit(state.copyWith(
        watchListMessage: '',
        isAddedtoWatchlist: result
      ));
    });
  }
}
