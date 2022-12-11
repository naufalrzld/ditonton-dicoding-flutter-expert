import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_top_rated_event.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, BaseBlocState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(Empty()) {
    on<OnFetchTopRatedMovie>((event, emit) async {
      emit(Loading());

      final result = await _getTopRatedMovies.execute();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
