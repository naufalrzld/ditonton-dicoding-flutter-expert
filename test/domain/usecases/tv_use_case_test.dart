import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvUseCase useCase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    useCase = TvUseCase(mockTvRepository);
  });

  final tTv = <Tv>[];

  test('should get on the air list of tv show from the repository', () async {
    // arrange
    when(mockTvRepository.getTvShowOnTheAir())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await useCase.getTvShowOnTheAir();
    // assert
    expect(result, Right(tTv));
  });

  test('should get popular list of tv show from the repository', () async {
    // arrange
    when(mockTvRepository.getPopularTvShow())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await useCase.getPopularTvShow();
    // assert
    expect(result, Right(tTv));
  });

  test('should get top rated of tv show from the repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTvShow())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await useCase.getTopRatedTvShow();
    // assert
    expect(result, Right(tTv));
  });

  test('should get tv show detail from the repository', () async {
    // arrange
    final tId = 1;
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await useCase.getDetailTvShow(tId);
    // assert
    expect(result, Right(testTvDetail));
  });

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    final tId = 1;
    final tTv = <Tv>[];
    when(mockTvRepository.getTvShowRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await useCase.getTvShowRecommendations(tId);
    // assert
    expect(result, Right(tTv));
  });

  test('should get list of tv show from the repository', () async {
    // arrange
    final tTv = <Tv>[];
    final tQuery = 'demona slayer';
    when(mockTvRepository.searchTvShow(tQuery))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await useCase.searchTVShow(tQuery);
    // assert
    expect(result, Right(tTv));
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTvRepository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await useCase.saveWatchList(testTvDetail);
    // assert
    verify(mockTvRepository.saveWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTvRepository.removeWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await useCase.removeWatchlist(testTvDetail);
    // assert
    verify(mockTvRepository.removeWatchlist(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await useCase.isAddedToWatchlist(1);
    // assert
    expect(result, true);
  });

  test('should get list of tv show from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvShow())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await useCase.getWatchlistTvShow();
    // assert
    expect(result, Right(testTvList));
  });
}
