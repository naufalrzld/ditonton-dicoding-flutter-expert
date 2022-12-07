import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv.dart';

class OnTheAirTvNotifier extends ChangeNotifier {
  final TvUseCase tvUseCase;

  OnTheAirTvNotifier({required this.tvUseCase});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnTheAirTvShow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getTvShowOnTheAir();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
