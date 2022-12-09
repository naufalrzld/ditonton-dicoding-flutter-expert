import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/base_bloc_state.dart';
import 'package:ditonton/presentation/bloc/tv/tv_ota_bloc.dart';
import 'package:ditonton/presentation/pages/tv_show/on_the_air_tv_show_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake_base_bloc_state.dart';

class TvOtaEventFake extends Fake implements TvOtaEvent {}

class MockTvOtaBloc extends MockBloc<TvOtaEvent, BaseBlocState>
    implements TvOtaBloc {}

void main() {
  late MockTvOtaBloc mockTvOtaBloc;

  setUpAll(() {
    registerFallbackValue(TvOtaEventFake());
    registerFallbackValue(BaseBlocStateFake());
  });

  setUp(() {
    mockTvOtaBloc = MockTvOtaBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvOtaBloc>.value(
      value: mockTvOtaBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvOtaBloc.state).thenReturn(Loading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvShowPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvOtaBloc.state).thenReturn(HasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvShowPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvOtaBloc.state).thenReturn(Error('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvShowPage()));

    expect(textFinder, findsOneWidget);
  });
}
