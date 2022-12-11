import 'package:bloc/bloc.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, BaseBlocState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(Empty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(Loading());
      final result = await _searchMovies.execute(query);

      result.fold((failure) {
        emit(Error(failure.message));
      }, (data) {
        emit(HasData(data));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
