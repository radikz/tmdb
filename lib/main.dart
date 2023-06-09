import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:search/presentation/pages/search_tv_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/episode_detail/episode_detail_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/popular/popular_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/recommendation/recommendation_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/season_detail/season_detail_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/airing_now_tvs_page.dart';
import 'package:tv/presentation/tv/pages/home_tv_page.dart';
import 'package:tv/presentation/tv/pages/popular_tvs_page.dart';
import 'package:tv/presentation/tv/pages/top_rated_tvs_page.dart';
import 'package:tv/presentation/tv/pages/tv_detail_episode_page.dart';
import 'package:tv/presentation/tv/pages/tv_detail_page.dart';
import 'package:tv/presentation/tv/pages/tv_season_page.dart';
import 'package:tv/presentation/tv/pages/watchlist_tvs_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<AiringNowTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<RecommendationTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<EpisodeDetailTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeasonDetailTvBloc>(),
        ),
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
