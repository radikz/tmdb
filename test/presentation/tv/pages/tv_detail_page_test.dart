import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/tv/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/tv/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Detail Tv', () {
    testWidgets("detail tv is loading", (tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.Loading);
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("detail tv is error", (tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn("error");
      final errorWidget = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(errorWidget, findsOneWidget);
    });

    group('Detail Tv is loaded', () {
      testWidgets("recommendation state is loading", (tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final loadingRecommendation =
            find.byKey(ValueKey("__recommendation_loading__tv"));

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(loadingRecommendation, findsOneWidget);
      });

      testWidgets("recommendation state is error", (tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.message).thenReturn("error");

        final errorRecom = find.byKey(ValueKey("__recommendation_error__tv"));

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets("recommendation state is empty", (tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final errorRecom = find.byKey(ValueKey("__recommendation_empty__tv"));

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets(
          "click recommendation item when recommendation state is loaded",
          (tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[testTv]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final inkWell = find.byKey(ValueKey("__recommendation_inkwell__tv"));

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(inkWell, findsOneWidget);
      });

      testWidgets("display seasons", (tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[testTv]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final inkwell = find.byKey(ValueKey("__season_inkwell__tv"));
        final text = find.byKey(ValueKey("__detail_season_text__tv"));

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(text, findsOneWidget);
        expect(inkwell, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display add icon when tv not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final loadingWidget = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should dispay check icon when tv is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final loadingWidget = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when removed from watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);
        when(mockNotifier.watchlistMessage)
            .thenReturn('Removed from Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Removed from Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvDetail).thenReturn(testTvDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
    });
  });
}
