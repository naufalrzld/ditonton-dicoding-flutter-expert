import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/tv_use_case.dart';

part 'tv_ota_event.dart';

class TvOtaBloc extends Bloc<TvOtaEvent, BaseBlocState> {
  final TvUseCase _useCase;

  TvOtaBloc(this._useCase) : super(Empty()) {
    on<OnFetchOta>((event, emit) async {
      emit(Loading());

      final result = await _useCase.getTvShowOnTheAir();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
