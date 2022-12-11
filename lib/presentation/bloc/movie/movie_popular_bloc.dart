import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_popular_movies.dart';

part 'movie_popular_event.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, BaseBlocState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(Empty()) {
    on<OnFetchPopularMovie>((event, emit) async {
      emit(Loading());

      final result = await _getPopularMovies.execute();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
