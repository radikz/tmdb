import 'package:core/core.dart';
import 'package:core/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({super.key});

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

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state.status == WatchlistMovieStatus.loading) {
              return const Center(
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
              return const EmptyPage();
            } else if (state.status == WatchlistMovieStatus.failure) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message!),
              );
            } else {
              return const SizedBox();
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
