import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([TvUseCase])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockTvUseCase mockTvUseCase;

  setUp(() {
    mockTvUseCase = MockTvUseCase();
    tvDetailBloc = TvDetailBloc(mockTvUseCase);
  });

  final tvDetailState = TvDetailState.init();
  final tId = 1;

  group('Get TV Show Detail', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state.tvDetailState, Empty());
    });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockTvUseCase.getDetailTvShow(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchDetailTv(tId)),
        expect: () => [
          tvDetailState.copyWith(tvDetailState: Loading()),
          tvDetailState.copyWith(tvDetailState: HasData(testTvDetail))
        ],
        verify: (bloc) => verify(mockTvUseCase.getDetailTvShow(tId))
    );

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockTvUseCase.getDetailTvShow(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchDetailTv(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          tvDetailState.copyWith(tvDetailState: Loading()),
          tvDetailState.copyWith(tvDetailState: Error('Server Failure'))
        ],
        verify: (bloc) => verify(mockTvUseCase.getDetailTvShow(tId))
    );
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
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvList = <Tv>[tTv];

  group('Get TV Show Recommendations', () {
    test('initial state should be empty', () {
      expect(tvDetailBloc.state.tvRecommendationState, Empty());
    });

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockTvUseCase.getTvShowRecommendations(tId))
              .thenAnswer((_) async => Right(tTvList));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchRecommendationTv(tId)),
        expect: () => [
          tvDetailState.copyWith(tvRecommendationState: Loading()),
          tvDetailState.copyWith(tvRecommendationState: HasData(tTvList))
        ],
        verify: (bloc) => verify(mockTvUseCase.getTvShowRecommendations(tId))
    );

    blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockTvUseCase.getTvShowRecommendations(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchRecommendationTv(tId)),
        expect: () => [
          tvDetailState.copyWith(tvRecommendationState: Loading()),
          tvDetailState.copyWith(tvRecommendationState: Error('Server Failure'))
        ],
        verify: (bloc) => verify(mockTvUseCase.getTvShowRecommendations(tId))
    );
  });
  
  group('Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should get the watchlist status',
      build: () {
        when(mockTvUseCase.isAddedToWatchlist(tId)).thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchListStatus(tId)),
      expect: () => [
        tvDetailState.copyWith(isAddedtoWatchlist: true)
      ],
      verify: (bloc) => verify(mockTvUseCase.isAddedToWatchlist(tId))
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockTvUseCase.saveWatchList(testTvDetail))
              .thenAnswer((_) async => Right('Success'));
        when(mockTvUseCase.isAddedToWatchlist(testTvDetail.id))
            .thenAnswer((_) async => true);
          return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddToWatchList(testTvDetail)),
      expect: () => [
        tvDetailState.copyWith(watchListMessage: 'Success'),
        tvDetailState.copyWith(
          isAddedtoWatchlist: true,
          watchListMessage: ''
        )
      ],
      verify: (bloc) {
        verify(mockTvUseCase.saveWatchList(testTvDetail));
        verify(mockTvUseCase.isAddedToWatchlist(testTvDetail.id));
      }
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockTvUseCase.removeWatchlist(testTvDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(mockTvUseCase.isAddedToWatchlist(testTvDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveFromWatchList(testTvDetail)),
      expect: () => [
        tvDetailState.copyWith(watchListMessage: 'Removed'),
        tvDetailState.copyWith(
            isAddedtoWatchlist: false,
            watchListMessage: ''
        )
      ],
      verify: (bloc) {
        verify(mockTvUseCase.removeWatchlist(testTvDetail));
        verify(mockTvUseCase.isAddedToWatchlist(testTvDetail.id));
      }
    );
  });
}