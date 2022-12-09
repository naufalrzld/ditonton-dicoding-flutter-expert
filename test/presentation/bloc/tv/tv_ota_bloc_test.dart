import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_ota_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_ota_bloc_test.mocks.dart';

@GenerateMocks([TvUseCase])
void main() {
  late TvOtaBloc tvOtaBloc;
  late MockTvUseCase mockTvUseCase;

  setUp(() {
    mockTvUseCase = MockTvUseCase();
    tvOtaBloc = TvOtaBloc(mockTvUseCase);
  });

  test('initial state should be empty', () {
    expect(tvOtaBloc.state, Empty());
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ["jp"],
    originalLanguage: 'jp',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 80,
    posterPath: 'posterPath',
    firstAirDate: '2002-05-01',
    name: 'name',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvList = <Tv>[tTv];

  blocTest<TvOtaBloc, BaseBlocState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTvUseCase.getTvShowOnTheAir())
          .thenAnswer((_) async => Right(tTvList));
      return tvOtaBloc;
    },
    act: (bloc) => bloc.add(OnFetchOta()),
    expect: () => [
      Loading(),
      HasData(tTvList)
    ],
    verify: (bloc) => verify(mockTvUseCase.getTvShowOnTheAir())
  );

  blocTest<TvOtaBloc, BaseBlocState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockTvUseCase.getTvShowOnTheAir())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvOtaBloc;
      },
      act: (bloc) => bloc.add(OnFetchOta()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        Loading(),
        Error('Server Failure')
      ],
      verify: (bloc) => verify(mockTvUseCase.getTvShowOnTheAir())
  );
}