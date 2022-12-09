import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_popular_bloc.dart';
import 'package:ditonton/presentation/pages/tv_show/popular_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_base_bloc_state.dart';

class TvPopularEventFake extends Fake implements TvPopularEvent {}

class MockTvPopularBloc extends MockBloc<TvPopularEvent, BaseBlocState>
    implements TvPopularBloc {}

void main() {
  late MockTvPopularBloc mockTvPopularBloc;

  setUpAll(() {
    registerFallbackValue(TvPopularEventFake());
    registerFallbackValue(BaseBlocStateFake());
  });

  setUp(() {
    mockTvPopularBloc = MockTvPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>.value(
      value: mockTvPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvPopularBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvPopularBloc.state).thenReturn(HasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvPopularBloc.state).thenReturn(Error('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowPage()));

    expect(textFinder, findsOneWidget);
  });
}
