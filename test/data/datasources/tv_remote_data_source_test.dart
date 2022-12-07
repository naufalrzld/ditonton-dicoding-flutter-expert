import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TV Show', () {
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/on_the_air.json'))
    ).tvList;

    test('should return list of TV Model when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/on_the_air.json'), 200));

      final result = await dataSource.getTvShowOnTheAir();

      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other',
      () async {
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        final call = dataSource.getTvShowOnTheAir();

        expect(() => call, throwsA(isA<ServerException>()));
      });
  });

  group('get Popular TV Show', () {
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/popular_tv.json'))
    ).tvList;

    test('should return list of movies when response is success (200)',
      () async {
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async =>
            http.Response(readJson('dummy_data/popular_tv.json'), 200));

        final result = await dataSource.getPopularTvShow();

        expect(result, tTvList);
      });

    test('should throw a ServerException when the response code is 404 or other',
      () async {
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        final call = dataSource.getPopularTvShow();

        expect(() => call, throwsA(isA<ServerException>()));
      });
  });

  group('get Top Rated TV Show', () {
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tv.json'))
    ).tvList;

    test('should return list of movies when response code is 200 ', () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated_tv.json'), 200));

      final result = await dataSource.getTopRatedTvShow();

      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
      () async {
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        final call = dataSource.getTopRatedTvShow();

        expect(() => call, throwsA(isA<ServerException>()));
      });
  });

  group('get tv show detail', () {
    final tId = 1;
    final tMovieDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv show detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvShowDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvShowDetail(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
  });

  group('get tv show recommendations', () {
    final tMovieList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient
            .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response(
            readJson('dummy_data/tv_recommendations.json'), 200));
        // act
        final result = await dataSource.getTvShowRecommendations(tId);
        // assert
        expect(result, equals(tMovieList));
      });

    test('should throw Server Exception when the response code is 404 or other',
      () async {
        // arrange
        when(mockHttpClient
            .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.getTvShowRecommendations(tId);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
  });

  group('search tv show', () {
    final tSearchResult = TvResponse.fromJson(
        json.decode(readJson('dummy_data/search_demon_slayer_tv.json')))
        .tvList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_demon_slayer_tv.json'), 200));
      // act
      final result = await dataSource.searchTvShow(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
      () async {
        // arrange
        when(mockHttpClient
            .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
            .thenAnswer((_) async => http.Response('Not Found', 404));
        // act
        final call = dataSource.searchTvShow(tQuery);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
  });
}