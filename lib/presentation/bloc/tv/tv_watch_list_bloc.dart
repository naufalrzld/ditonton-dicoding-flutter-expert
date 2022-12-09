import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/tv_use_case.dart';

part 'tv_watch_list_event.dart';

class TvWatchListBloc extends Bloc<TvWatchListEvent, BaseBlocState> {
  final TvUseCase _useCase;

  TvWatchListBloc(this._useCase) : super(Empty()) {
    on<OnFetchWatchListTv>((event, emit) async {
      emit(Loading());

      final result = await _useCase.getWatchlistTvShow();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
