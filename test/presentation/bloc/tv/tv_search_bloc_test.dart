import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([TvUseCase])
void main() {
  late TvSearchBloc searchBloc;
  late MockTvUseCase mockTvUseCase;

  setUp(() {
    mockTvUseCase = MockTvUseCase();
    searchBloc = TvSearchBloc(mockTvUseCase);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, Empty());
  });

  final tTvModel = Tv(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originCountry: ["jp"],
    originalLanguage: 'jp',
    originalName: 'Demon Slayer',
    overview: 'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Demon Slayer',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'demon slayer';

  blocTest<TvSearchBloc, BaseBlocState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockTvUseCase.searchTVShow(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      Loading(),
      HasData(tTvList)
    ],
    verify: (bloc) => verify(mockTvUseCase.searchTVShow(tQuery))
  );

  blocTest<TvSearchBloc, BaseBlocState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockTvUseCase.searchTVShow(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        Loading(),
        Error('Server Failure')
      ],
      verify: (bloc) => verify(mockTvUseCase.searchTVShow(tQuery))
  );
}