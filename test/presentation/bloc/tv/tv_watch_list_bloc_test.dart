import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_watch_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_watch_list_bloc_test.mocks.dart';

@GenerateMocks([TvUseCase])
void main() {
  late TvWatchListBloc tvWatchListBloc;
  late MockTvUseCase mockTvUseCase;

  setUp(() {
    mockTvUseCase = MockTvUseCase();
    tvWatchListBloc = TvWatchListBloc(mockTvUseCase);
  });

  test('initial state should be empty', () {
    expect(tvWatchListBloc.state, Empty());
  });

  blocTest<TvWatchListBloc, BaseBlocState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTvUseCase.getWatchlistTvShow())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      return tvWatchListBloc;
    },
    act: (bloc) => bloc.add(OnFetchWatchListTv()),
    expect: () => [
      Loading(),
      HasData([testWatchlistTv])
    ],
    verify: (bloc) => verify(mockTvUseCase.getWatchlistTvShow())
  );


  blocTest<TvWatchListBloc, BaseBlocState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockTvUseCase.getWatchlistTvShow())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      return tvWatchListBloc;
    },
    act: (bloc) => bloc.add(OnFetchWatchListTv()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      Error("Can't get data")
    ],
    verify: (bloc) => verify(mockTvUseCase.getWatchlistTvShow())
  );
}