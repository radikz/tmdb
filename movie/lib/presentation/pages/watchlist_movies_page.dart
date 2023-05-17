import 'package:core/core.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:core/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state.status == WatchlistMovieStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == WatchlistMovieStatus.success) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.watchlistMovies[index];
                  return MovieCard(movie);
                },
                itemCount: state.watchlistMovies.length,
              );
            } else if (state.status == WatchlistMovieStatus.empty) {
              return EmptyPage();
            } else if (state.status == WatchlistMovieStatus.failure) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message!),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
