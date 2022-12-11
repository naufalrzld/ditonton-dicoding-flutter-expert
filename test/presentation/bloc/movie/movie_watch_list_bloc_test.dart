import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/movie/movie_watch_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_watch_list_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MovieWatchListBloc movieWatchListBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    movieWatchListBloc = MovieWatchListBloc(mockGetWatchlistMovies);
  });

  test('initial state should be empty', () {
    expect(movieWatchListBloc.state, Empty());
  });

  blocTest<MovieWatchListBloc, BaseBlocState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return movieWatchListBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchListMovie()),
      expect: () => [
        Loading(),
        HasData([testWatchlistMovie])
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute())
  );


  blocTest<MovieWatchListBloc, BaseBlocState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return movieWatchListBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchListMovie()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        Loading(),
        Error("Can't get data")
      ],
      verify: (bloc) => verify(mockGetWatchlistMovies.execute())
  );
}