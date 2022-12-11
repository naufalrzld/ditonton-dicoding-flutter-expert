import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_now_playing_movies.dart';

part 'movie_now_playing_event.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, BaseBlocState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(this._getNowPlayingMovies) : super(Empty()) {
    on<OnFetchNowPlayingMovie>((event, emit) async {
      emit(Loading());

      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
