import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/tv/bloc/recommendation/recommendation_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/tv_detail_page.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class MockWatchlistTvBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class MockRecommendationTvBloc
    extends MockBloc<RecommendationTvEvent, RecommendationTvState>
    implements RecommendationTvBloc {}

void main() {
  late MockTvDetailBloc movieDetailBloc;
  late MockRecommendationTvBloc recommendationTvBloc;
  late MockWatchlistTvBloc watchlistTvBloc;

  setUp(() {
    movieDetailBloc = MockTvDetailBloc();
    recommendationTvBloc = MockRecommendationTvBloc();
    watchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>.value(
          value: movieDetailBloc,
        ),
        BlocProvider<RecommendationTvBloc>.value(
          value: recommendationTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>.value(
          value: watchlistTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testTvList = <Tv>[testTv];

  group('Detail Tv', () {
    testWidgets("detail tv is loading", (tester) async {
      when(() => movieDetailBloc.state).thenReturn(TvDetailLoading());
      when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());

      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("detail tv is error", (tester) async {
      when(() => movieDetailBloc.state).thenReturn(const TvDetailFailure("error"));
      when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());
      final errorWidget = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

      expect(errorWidget, findsOneWidget);
    });

    group('Detail Tv is loaded', () {
      testWidgets("recommendation state is loading", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoading());
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());

        final loadingRecommendation =
            find.byKey(const ValueKey("__recommendation_loading__tv"));

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(loadingRecommendation, findsOneWidget);
      });

      testWidgets("recommendation state is error", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(const RecommendationTvFailure("error"));
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());

        final errorRecom = find.byKey(const ValueKey("__recommendation_error__tv"));

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets("recommendation state is empty", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvEmpty());
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());

        final errorRecom = find.byKey(const ValueKey("__recommendation_empty__tv"));

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets(
          "click recommendation item when recommendation state is loaded",
          (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());

        final inkWell = find.byKey(const ValueKey("__recommendation_inkwell__tv"));

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(inkWell, findsOneWidget);
      });

      testWidgets("display seasons", (tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState());

        final inkwell = find.byKey(const ValueKey("__season_inkwell__tv"));
        final text = find.byKey(const ValueKey("__detail_season_text__tv"));

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(text, findsOneWidget);
        expect(inkwell, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display add icon when tv not added to watchlist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state)
            .thenReturn(const WatchlistTvState(isAddedToWatchlist: false));

        final loadingWidget = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should dispay check icon when tv is added to wathclist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state)
            .thenReturn(const WatchlistTvState(isAddedToWatchlist: true));

        final loadingWidget = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState(
            isAddedToWatchlist: false, message: "Added to Watchlist"));
        whenListen<WatchlistTvState>(
          watchlistTvBloc,
          Stream.fromIterable(const [
            WatchlistTvState(isAddedToWatchlist: false),
            WatchlistTvState(
                isAddedToWatchlist: false, message: "Added to Watchlist"),
          ]),
        );

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when removed from watchlist',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state).thenReturn(const WatchlistTvState(
            isAddedToWatchlist: true, message: "Removed from Watchlist"));
        whenListen<WatchlistTvState>(
          watchlistTvBloc,
          Stream.fromIterable(const [
            WatchlistTvState(isAddedToWatchlist: true),
            WatchlistTvState(
                isAddedToWatchlist: true, message: "Removed from Watchlist"),
          ]),
        );

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Removed from Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(() => movieDetailBloc.state)
            .thenReturn(TvDetailLoaded(testTvDetail));
        when(() => recommendationTvBloc.state)
            .thenReturn(RecommendationTvLoaded(testTvList));
        when(() => watchlistTvBloc.state).thenReturn(
            const WatchlistTvState(isAddedToWatchlist: false, message: 'Failed'));
        whenListen<WatchlistTvState>(
          watchlistTvBloc,
          Stream.fromIterable(const [
            WatchlistTvState(isAddedToWatchlist: false),
            WatchlistTvState(isAddedToWatchlist: false, message: "Failed"),
          ]),
        );

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
    });
  });
}
