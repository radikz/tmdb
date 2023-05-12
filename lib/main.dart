import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/movie_search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:search/presentation/pages/search_tv_page.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/tv/pages/airing_now_tvs_page.dart';
import 'package:ditonton/presentation/tv/pages/home_tv_page.dart';
import 'package:ditonton/presentation/tv/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/tv/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/tv/pages/tv_detail_episode_page.dart';
import 'package:ditonton/presentation/tv/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/tv/pages/tv_season_page.dart';
import 'package:ditonton/presentation/tv/pages/watchlist_tvs_page.dart';
import 'package:ditonton/presentation/tv/provider/airing_now_tvs_notifier.dart';
import 'package:ditonton/presentation/tv/provider/episode_detail_tv_notifier.dart';
import 'package:ditonton/presentation/tv/provider/popular_tvs_notifier.dart';
import 'package:ditonton/presentation/tv/provider/season_detail_tv_notifier.dart';
import 'package:ditonton/presentation/tv/provider/top_rated_tvs_notifier.dart';
import 'package:ditonton/presentation/tv/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/tv/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/tv/provider/watchlist_tv_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AiringNowTvsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<EpisodeDetailTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeasonDetailTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieSearchBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviesRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMoviesRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case watchlistMoviesRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case homeTvsRoute:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case airingTvsRoute:
              return MaterialPageRoute(builder: (_) => AiringNowTvsPage());
            case popularTvsRoute:
              return MaterialPageRoute(builder: (_) => PopularTvsPage());
            case topRatedTvsRoute:
              return MaterialPageRoute(builder: (_) => TopRatedTvsPage());
            case watchlistTvsRoute:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());
            case tvDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case tvDetailEpisodeRoute:
              final arg = settings.arguments as TvDetailEpisodeArg;
              return MaterialPageRoute(
                builder: (_) => TvDetailEpisodePage(arg: arg),
                settings: settings,
              );
            case tvSeasonRoute:
              final arg = settings.arguments as TvSeasonArg;
              return MaterialPageRoute(
                builder: (_) => TvSeasonPage(arg: arg),
                settings: settings,
              );
            case searchTvsRoute:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
