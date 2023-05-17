import 'package:bloc_test/bloc_test.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import '../../helper/dummy.dart';

class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

void main() {
  late MockTopRatedMovieBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    // print("status bloc popular ${mockBloc.state}");
    when(() => mockBloc.state).thenReturn(TopRatedMovieLoading());
    print("status bloc popular ${mockBloc.state}");
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  group('when data is loaded', () {
    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockBloc.state)
          .thenReturn(const TopRatedMovieLoaded(<Movie>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display item when loaded',
        (WidgetTester tester) async {
      when(() => mockBloc.state)
          .thenReturn(const TopRatedMovieLoaded(<Movie>[testMovie]));

      final itemFinder = find.byType(MovieCard);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(itemFinder, findsOneWidget);
    });
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const TopRatedMovieFailure("Error"));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
