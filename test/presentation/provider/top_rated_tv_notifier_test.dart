import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([TvUseCase])
void main() {
  late MockTvUseCase mockTvUseCase;
  late TopRatedTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockTvUseCase = MockTvUseCase();
    notifier = TopRatedTvNotifier(tvUseCase: mockTvUseCase)
      ..addListener(() {
        listenerCallCount++;
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

  final tvList = <Tv>[tTv];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockTvUseCase.getTopRatedTvShow())
        .thenAnswer((_) async => Right(tvList));
    // act
    notifier.fetchTopRatedTvShow();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv show data when data is gotten successfully', () async {
    // arrange
    when(mockTvUseCase.getTopRatedTvShow())
        .thenAnswer((_) async => Right(tvList));
    // act
    await notifier.fetchTopRatedTvShow();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockTvUseCase.getTopRatedTvShow())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTvShow();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}