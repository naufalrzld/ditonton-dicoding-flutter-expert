import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/tv_use_case.dart';

part 'tv_popular_event.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, BaseBlocState> {
  final TvUseCase _tvUseCase;

  TvPopularBloc(this._tvUseCase) : super(Empty()) {
    on<OnFetchPopularTv>((event, emit) async {
      emit(Loading());

      final result = await _tvUseCase.getPopularTvShow();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
