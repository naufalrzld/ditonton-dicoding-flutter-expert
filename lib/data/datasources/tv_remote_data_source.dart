import 'dart:convert';

import 'package:ditonton/data/datasources/api_services.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:http/http.dart' as http;

import '../../common/exception.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getTvShowOnTheAir();
  Future<List<TvModel>> getPopularTvShow();
  Future<List<TvModel>> getTopRatedTvShow();
  Future<TvDetailResponse> getTvShowDetail(int id);
  Future<List<TvModel>> getTvShowRecommendations(int id);
  Future<List<TvModel>> searchTvShow(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;

  String _baseUrl = ApiService.BASE_URL;
  String _apiKey = ApiService.API_KEY;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvModel>> getTvShowOnTheAir() async {
    final response = await client.get(Uri.parse('$_baseUrl/tv/on_the_air?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTvShow() async {
    final response = await client.get(Uri.parse('$_baseUrl/tv/popular?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTvShow() async {
    final response = await client.get(Uri.parse('$_baseUrl/tv/top_rated?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailResponse> getTvShowDetail(int id) async {
    final response = await client.get(Uri.parse('$_baseUrl/tv/$id?$_apiKey'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvShowRecommendations(int id) async {
    final response = await client.get(Uri.parse('$_baseUrl/tv/$id/recommendations?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTvShow(String query) async {
    final response = await client
        .get(Uri.parse('$_baseUrl/search/tv?$_apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}