import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/pages/tv_show/top_rated_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_base_bloc_state.dart';

class TvTopRatedEventFake extends Fake implements TvTopRatedEvent {}

class MockTvTopRatedBloc extends MockBloc<TvTopRatedEvent, BaseBlocState>
    implements TvTopRatedBloc {}

void main() {
  late MockTvTopRatedBloc mockTvTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TvTopRatedEventFake());
    registerFallbackValue(BaseBlocStateFake());
  });

  setUp(() {
    mockTvTopRatedBloc = MockTvTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedBloc>.value(
      value: mockTvTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvTopRatedBloc.state).thenReturn(Loading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvTopRatedBloc.state).thenReturn(HasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvTopRatedBloc.state).thenReturn(Error('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowPage()));

    expect(textFinder, findsOneWidget);
  });
}
