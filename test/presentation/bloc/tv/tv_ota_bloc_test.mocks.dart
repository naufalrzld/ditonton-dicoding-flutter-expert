// Mocks generated by Mockito 5.3.0 from annotations
// in ditonton/test/presentation/bloc/tv/tv_ota_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv.dart' as _i7;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i8;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/tv_use_case.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTvRepository_0 extends _i1.SmartFake implements _i2.TvRepository {
  _FakeTvRepository_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [TvUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvUseCase extends _i1.Mock implements _i4.TvUseCase {
  MockTvUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
              returnValue:
                  _FakeTvRepository_0(this, Invocation.getter(#repository)))
          as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getTvShowOnTheAir() =>
      (super.noSuchMethod(Invocation.method(#getTvShowOnTheAir, []),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
                  this, Invocation.method(#getTvShowOnTheAir, [])))) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getPopularTvShow() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvShow, []),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
                  this, Invocation.method(#getPopularTvShow, [])))) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getTopRatedTvShow() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvShow, []),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
                  this, Invocation.method(#getTopRatedTvShow, [])))) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i8.TvDetail>> getDetailTvShow(int? id) =>
      (super.noSuchMethod(Invocation.method(#getDetailTvShow, [id]),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, _i8.TvDetail>>.value(
              _FakeEither_1<_i6.Failure, _i8.TvDetail>(
                  this, Invocation.method(#getDetailTvShow, [id])))) as _i5
          .Future<_i3.Either<_i6.Failure, _i8.TvDetail>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getTvShowRecommendations(
          dynamic id) =>
      (super.noSuchMethod(Invocation.method(#getTvShowRecommendations, [id]),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Tv>>(this,
                  Invocation.method(#getTvShowRecommendations, [id])))) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> searchTVShow(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTVShow, [query]),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
                  this, Invocation.method(#searchTVShow, [query])))) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> saveWatchList(_i8.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#saveWatchList, [tv]),
              returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>(
                      this, Invocation.method(#saveWatchList, [tv]))))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> removeWatchlist(
          _i8.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
              returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>(
                      this, Invocation.method(#removeWatchlist, [tv]))))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
  @override
  _i5.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: _i5.Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> getWatchlistTvShow() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvShow, []),
          returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Tv>>(
                  this, Invocation.method(#getWatchlistTvShow, [])))) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
}
