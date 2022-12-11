import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/movie/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist
    );
  });

  final movieDetailState = MovieDetailState.init();
  final tId = 1;

  group('Get Movie Detail', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state.movieDetailState, Empty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchDetailMovie(tId)),
        expect: () => [
          movieDetailState.copyWith(movieDetailState: Loading()),
          movieDetailState.copyWith(movieDetailState: HasData(testMovieDetail))
        ],
        verify: (bloc) => verify(mockGetMovieDetail.execute(tId))
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchDetailMovie(tId)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          movieDetailState.copyWith(movieDetailState: Loading()),
          movieDetailState.copyWith(movieDetailState: Error('Server Failure'))
        ],
        verify: (bloc) => verify(mockGetMovieDetail.execute(tId))
    );
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  group('Get Movie Recommendations', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state.movieRecommendationState, Empty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchRecommendationMovie(tId)),
        expect: () => [
          movieDetailState.copyWith(movieRecommendationState: Loading()),
          movieDetailState.copyWith(movieRecommendationState: HasData(tMovies))
        ],
        verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId))
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchRecommendationMovie(tId)),
        expect: () => [
          movieDetailState.copyWith(movieRecommendationState: Loading()),
          movieDetailState.copyWith(movieRecommendationState: Error('Server Failure'))
        ],
        verify: (bloc) => verify(mockGetMovieRecommendations.execute(tId))
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListStatus(tId)),
        expect: () => [
          movieDetailState.copyWith(isAddedtoWatchlist: true)
        ],
        verify: (bloc) => verify(mockGetWatchlistStatus.execute(tId))
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should execute save watchlist when function called',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Success'));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnAddToWatchList(testMovieDetail)),
        expect: () => [
          movieDetailState.copyWith(watchListMessage: 'Success'),
          movieDetailState.copyWith(
              isAddedtoWatchlist: true,
              watchListMessage: ''
          )
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(tId));
        }
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should execute remove watchlist when function called',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed'));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => false);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnRemoveFromWatchList(testMovieDetail)),
        expect: () => [
          movieDetailState.copyWith(watchListMessage: 'Removed'),
          movieDetailState.copyWith(
              isAddedtoWatchlist: false,
              watchListMessage: ''
          )
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchlistStatus.execute(tId));
        }
    );
  });
}