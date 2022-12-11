import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_watchlist_movies.dart';

part 'movie_watch_list_event.dart';

class MovieWatchListBloc extends Bloc<MovieWatchListEvent, BaseBlocState> {
  final GetWatchlistMovies _getWatchlistMovies;

  MovieWatchListBloc(this._getWatchlistMovies) : super(Empty()) {
    on<MovieWatchListEvent>((event, emit) async {
      emit(Loading());

      final result = await _getWatchlistMovies.execute();

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    });
  }
}
