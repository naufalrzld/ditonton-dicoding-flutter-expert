import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

import '../../common/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class TvUseCase {
  final TvRepository repository;

  TvUseCase(this.repository);

  Future<Either<Failure, List<Tv>>> getTvShowOnTheAir() {
    return repository.getTvShowOnTheAir();
  }

  Future<Either<Failure, List<Tv>>> getPopularTvShow() {
    return repository.getPopularTvShow();
  }

  Future<Either<Failure, List<Tv>>> getTopRatedTvShow() {
    return repository.getTopRatedTvShow();
  }

  Future<Either<Failure, TvDetail>> getDetailTvShow(int id) {
    return repository.getTvDetail(id);
  }

  Future<Either<Failure, List<Tv>>> getTvShowRecommendations(id) {
    return repository.getTvShowRecommendations(id);
  }

  Future<Either<Failure, List<Tv>>> searchTVShow(String query) {
    return repository.searchTvShow(query);
  }

  Future<Either<Failure, String>> saveWatchList(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }

  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) {
    return repository.removeWatchlist(tv);
  }

  Future<bool> isAddedToWatchlist(int id) async {
    return repository.isAddedToWatchlist(id);
  }

  Future<Either<Failure, List<Tv>>> getWatchlistTvShow() {
    return repository.getWatchlistTvShow();
  }
}