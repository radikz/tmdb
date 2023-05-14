import 'package:core/utils/state_enum.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:provider/provider.dart';

import '../../helper/dummy.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Detail Movie', () {
    testWidgets("detail movie is loading", (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loading);
      final loadingWidget = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(loadingWidget, findsOneWidget);
    });

    testWidgets("detail movie is error", (tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn("error");
      final errorWidget = find.byType(Text);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(errorWidget, findsOneWidget);
    });

    group('Detail Movie is loaded', () {
      testWidgets("recommendation state is loading", (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final loadingRecommendation =
            find.byKey(ValueKey("__recommendation_loading__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(loadingRecommendation, findsOneWidget);
      });

      testWidgets("recommendation state is error", (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.message).thenReturn("error");

        final errorRecom = find.byKey(ValueKey("__recommendation_error__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets("recommendation state is empty", (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Empty);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final errorRecom = find.byKey(ValueKey("__recommendation_empty__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(errorRecom, findsOneWidget);
      });

      testWidgets(
          "click recommendation item when recommendation state is loaded",
          (tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.movieRecommendations).thenReturn(testMovieList);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final inkWell = find.byKey(ValueKey("__recommendation_inkwell__"));

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(inkWell, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final loadingWidget = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final loadingWidget = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(loadingWidget, findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display Snackbar when removed from watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);
        when(mockNotifier.watchlistMessage)
            .thenReturn('Removed from Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.check), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Removed from Watchlist'), findsOneWidget);
      });

      testWidgets(
          'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
    });
  });
}
