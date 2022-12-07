import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_use_case.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/tv.dart';

class PopularTvNotifier extends ChangeNotifier {
  final TvUseCase tvUseCase;

  PopularTvNotifier({required this.tvUseCase});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvShow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await tvUseCase.getPopularTvShow();

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
