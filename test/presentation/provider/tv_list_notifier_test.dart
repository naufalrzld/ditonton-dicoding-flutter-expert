import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([TvUseCase])
void main() {
  late TvListNotifier provider;
  late MockTvUseCase mockTvUseCase;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockTvUseCase = MockTvUseCase();
    provider = TvListNotifier(tvUseCase: mockTvUseCase)
      ..addListener(() {
        listenerCallCount += 1;
      });
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

  group('on the air tv show', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockTvUseCase.getTvShowOnTheAir())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTv();
      // assert
      verify(mockTvUseCase.getTvShowOnTheAir());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockTvUseCase.getTvShowOnTheAir())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchOnTheAirTv();
      // assert
      expect(provider.onTheAirState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockTvUseCase.getTvShowOnTheAir())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchOnTheAirTv();
      // assert
      expect(provider.onTheAirState, RequestState.Loaded);
      expect(provider.onTheAirTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockTvUseCase.getTvShowOnTheAir())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTv();
      // assert
      expect(provider.onTheAirState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockTvUseCase.getPopularTvShow())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTvShow();
      // assert
      expect(provider.popularTvShowState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockTvUseCase.getPopularTvShow())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTvShow();
      // assert
      expect(provider.popularTvShowState, RequestState.Loaded);
      expect(provider.popularTvShow, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockTvUseCase.getPopularTvShow())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShow();
      // assert
      expect(provider.popularTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv show', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockTvUseCase.getTopRatedTvShow())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTvShow();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockTvUseCase.getTopRatedTvShow())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTvShow();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Loaded);
      expect(provider.topRatedTvShow, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockTvUseCase.getTopRatedTvShow())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShow();
      // assert
      expect(provider.topRatedTvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
