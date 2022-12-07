import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv.dart';

class TvListNotifier extends ChangeNotifier {
  var _onTheAirTv = <Tv>[];
  List<Tv> get onTheAirTv => _onTheAirTv;

  RequestState _onTheAirState = RequestState.Empty;
  RequestState get onTheAirState => _onTheAirState;

  var _popularTvShow = <Tv>[];
  List<Tv> get popularTvShow => _popularTvShow;

  RequestState _popularTvShowState = RequestState.Empty;
  RequestState get popularTvShowState => _popularTvShowState;

  var _topRatedTvShow = <Tv>[];
  List<Tv> get topRatedTvShow => _topRatedTvShow;

  RequestState _topRatedTvShowState = RequestState.Empty;
  RequestState get topRatedTvShowState => _topRatedTvShowState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.tvUseCase
  });

  final TvUseCase tvUseCase;

  Future<void> fetchOnTheAirTv() async {
    _onTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getTvShowOnTheAir();
    result.fold(
      (failure) {
        _onTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirState = RequestState.Loaded;
        _onTheAirTv = tvData;
        notifyListeners();
      }
    );
  }

  Future<void> fetchPopularTvShow() async {
    _popularTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getPopularTvShow();
    result.fold(
      (failure) {
        _popularTvShowState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvShowState = RequestState.Loaded;
        _popularTvShow = tvData;
        notifyListeners();
      }
    );
  }

  Future<void> fetchTopRatedTvShow() async {
    _topRatedTvShowState = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getTopRatedTvShow();
    result.fold(
            (failure) {
          _topRatedTvShowState = RequestState.Error;
          _message = failure.message;
          notifyListeners();
        },
            (tvData) {
          _topRatedTvShowState = RequestState.Loaded;
          _topRatedTvShow = tvData;
          notifyListeners();
        }
    );
  }
}