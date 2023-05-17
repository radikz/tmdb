import 'package:core/core.dart';
import 'package:core/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';

class WatchlistTvsPage extends StatefulWidget {
  const WatchlistTvsPage({super.key});

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistTvsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvBloc>().add(FetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tvs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state.status == WatchlistTvStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == WatchlistTvStatus.success) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.watchlistTvs[index];
                  return TvCard(tv);
                },
                itemCount: state.watchlistTvs.length,
              );
            } else if (state.status == WatchlistTvStatus.failure) {
              return Center(
                key: const Key('error_message_tv'),
                child: Text(state.message!),
              );
            } else if (state.status == WatchlistTvStatus.empty) {
              return const EmptyPage();
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
