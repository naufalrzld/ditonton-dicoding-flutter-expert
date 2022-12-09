import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/tv_use_case.dart';
import '../base_bloc_state.dart';

part 'tv_top_rated_event.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, BaseBlocState> {
  final TvUseCase _useCase;

  TvTopRatedBloc(this._useCase) : super(Empty()) {
    on<OnFetchTopRatedTv>((event, emit) async {
      emit(Loading());

      final result = await _useCase.getTopRatedTvShow();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
