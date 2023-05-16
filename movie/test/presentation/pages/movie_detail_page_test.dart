import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../helper/dummy.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class MockRecommendationMovieBloc
    extends MockBloc<RecommendationMovieEvent, RecommendationMovieState>
    implements RecommendationMovieBloc {}

void main() {
  late MockMovieDetailBloc movieDetailBloc;
  late MockRecommendationMovieBloc recommendationMovieBloc;
  late MockWatchlistMovieBloc watchlistMovieBloc;

  setUpAll(() {
    movieDetailBloc = MockMovieDetailBloc();
    recommendationMovieBloc = MockRecommendationMovieBloc();
    watchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(
          value: movieDetailBloc,
        ),
        BlocProvider<RecommendationMovieBloc>.value(
          value: recommendationMovieBloc,
        ),
        BlocProvider<WatchlistMovieBloc>.value(
          value: watchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Detail Movie', () {
    testWidgets("detail movie is loading", (tester) async {
      when(() => movieDetailBloc.state).thenReturn(MovieDetailLoading());
      when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState());
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("detail movie is error", (tester) async {
      when(() => movieDetailBloc.state).thenReturn(MovieDetailFailure("error"));
      when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState());
      final errorWidget = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(errorWidget, findsOneWidget);
    });

    group('Detail Movie is loaded', () {
      testWidgets("recommendation state is loading", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoading());
        when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState());

        final loadingRecommendation =
            find.byKey(ValueKey("__recommendation_loading__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(loadingRecommendation, findsOneWidget);
      });

      testWidgets("recommendation state is error", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieFailure("error"));
        when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState());

        final errorRecom = find.byKey(ValueKey("__recommendation_error__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets("recommendation state is empty", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieEmpty());
        when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState());

        final errorRecom = find.byKey(ValueKey("__recommendation_empty__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets(
          "click recommendation item when recommendation state is loaded",
          (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoaded(testMovieList));
        when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState());

        final inkWell = find.byKey(ValueKey("__recommendation_inkwell__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(inkWell, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoaded(testMovieList));
        when(() => watchlistMovieBloc.state)
            .thenReturn(WatchlistMovieState(isAddedToWatchlist: false));

        final loadingWidget = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoaded(testMovieList));
        when(() => watchlistMovieBloc.state)
            .thenReturn(WatchlistMovieState(isAddedToWatchlist: true));

        final loadingWidget = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when added new watchlist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoaded(testMovieList));
        when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState(
            isAddedToWatchlist: false, message: "Added to Watchlist"));
        whenListen<WatchlistMovieState>(
          watchlistMovieBloc,
          Stream.fromIterable(const [
            WatchlistMovieState(isAddedToWatchlist: false),
            WatchlistMovieState(
                isAddedToWatchlist: false, message: "Added to Watchlist"),
          ]),
        );

        final watchlistButton = find.byKey(ValueKey("watchlist_movie_button"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        expect(watchlistButton, findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byKey(ValueKey("watchlist_movie_snackbar")),
            findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when removed from watchlist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoaded(testMovieList));
        when(() => watchlistMovieBloc.state).thenReturn(WatchlistMovieState(
            isAddedToWatchlist: true, message: "Removed from Watchlist"));
        whenListen<WatchlistMovieState>(
          watchlistMovieBloc,
          Stream.fromIterable(const [
            WatchlistMovieState(isAddedToWatchlist: true),
            WatchlistMovieState(
                isAddedToWatchlist: true, message: "Removed from Watchlist"),
          ]),
        );

        final watchlistButton = find.byKey(ValueKey("watchlist_movie_button"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byKey(Key("movie_detail_icon_check")), findsOneWidget);

        expect(watchlistButton, findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byKey(ValueKey("watchlist_movie_snackbar")),
            findsOneWidget);
        expect(find.text('Removed from Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(MovieDetailLoaded(testMovieDetail));
        when(() => recommendationMovieBloc.state)
            .thenReturn(RecommendationMovieLoaded(testMovieList));
        when(() => watchlistMovieBloc.state).thenReturn(
            WatchlistMovieState(isAddedToWatchlist: false, message: 'Failed'));
        whenListen<WatchlistMovieState>(
          watchlistMovieBloc,
          Stream.fromIterable(const [
            WatchlistMovieState(isAddedToWatchlist: false),
            WatchlistMovieState(isAddedToWatchlist: false, message: "Failed"),
          ]),
        );

        final watchlistButton = find.byKey(ValueKey("watchlist_movie_button"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byKey(ValueKey("watchlist_movie_error_alert_dialog")), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
    });
  });
}
