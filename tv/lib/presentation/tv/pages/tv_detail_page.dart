import 'package:core/core.dart';
import 'package:core/movie/domain/entities/genre.dart';
import 'package:core/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/tv/bloc/recommendation/recommendation_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:tv/presentation/tv/pages/tv_detail_episode_page.dart';
import 'package:tv/presentation/tv/pages/tv_season_page.dart';

class TvDetailPage extends StatefulWidget {
  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
    context.read<RecommendationTvBloc>().add(FetchRecommendationTv(widget.id));
    context.read<WatchlistTvBloc>().add(FetchWatchlistStatusTv(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistTvBloc, WatchlistTvState>(
      listener: (context, state) {
       final message = state.message;
        if (state.message != null) {
          if (message == watchlistAddSuccessMessage ||
              message == watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(key: const ValueKey("watchlist_tv_snackbar"), content: Text(message!)));
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    key: const ValueKey("watchlist_tv_error_alert_dialog"),
                    content: Text(message!),
                  );
                });
          }
        }
      },
      child: Scaffold(
        body: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailLoaded) {
              final movie = state.result;
              return SafeArea(
                child: DetailContent(
                  movie,
                ),
              );
            } else if (state is TvDetailFailure) {
              return Text(state.message);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;

  const DetailContent(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AppNetworkImage(
          imageUrl: '${tv.posterPath}',
          width: screenWidth,
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        key: const ValueKey("detail_scrollview"),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              key: const ValueKey("watchlist_tv_button"),
                              onPressed: () async {
                                final isAddedWatchlist = context
                                    .read<WatchlistTvBloc>()
                                    .state
                                    .isAddedToWatchlist;

                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(AddWatchlistTv(tv));
                                } else {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(RemoveWatchlistTvEvent(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BlocBuilder<WatchlistTvBloc,
                                      WatchlistTvState>(
                                    builder: (context, state) {
                                      final isAddedWatchlist =
                                          state.isAddedToWatchlist;
                                      return isAddedWatchlist
                                          ? const Icon(Icons.check, key: Key("tv_detail_icon_check"),)
                                          : const Icon(Icons.add);
                                    },
                                  ),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              _showDuration(0),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              key: const ValueKey("__detail_recommendation_text__tv"),
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvBloc, RecommendationTvState>(
                              builder: (context, state) {
                                if (state is RecommendationTvLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      key: ValueKey(
                                          "__recommendation_loading__tv"),
                                    ),
                                  );
                                } else if (state is RecommendationTvFailure) {
                                  return Text(state.message,
                                      key: const ValueKey(
                                          "__recommendation_error__tv"));
                                } else if (state is RecommendationTvLoaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            key: const ValueKey(
                                                "__recommendation_inkwell__tv"),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                tvDetailRoute,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: AppNetworkImage(
                                                  imageUrl:
                                                      '${tv.posterPath}'),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    key: const ValueKey("__recommendation_empty__tv"),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Season',
                              key: const ValueKey("__detail_season_text__tv"),
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = tv.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      key: const ValueKey("__season_inkwell__tv"),
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          tvSeasonRoute,
                                          arguments: TvSeasonArg(
                                              tvId: tv.id,
                                              seasonNumber:
                                                  season.seasonNumber),
                                        );
                                      },
                                      child: Visibility(
                                        visible: season.posterPath != null,
                                        replacement: Container(
                                            width: 100,
                                            color: Colors.grey,
                                            child: const Center(
                                              child: Icon(
                                                Icons.tv,
                                                color: Colors.black,
                                              ),
                                            )),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: AppNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${season.posterPath}'),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: tv.seasons.length,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Episode',
                              key: const ValueKey("__detail_episode_text__tv"),
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  key: const ValueKey("__episode_inkwell__tv"),
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      tvDetailEpisodeRoute,
                                      arguments: TvDetailEpisodeArg(
                                          tvId: tv.id,
                                          seasonNumber: tv
                                              .lastEpisodeToAir.seasonNumber,
                                          episodeNumber: tv
                                              .lastEpisodeToAir.episodeNumber),
                                    );
                                  },
                                  child: Visibility(
                                    visible: tv.lastEpisodeToAir.stillPath !=
                                        null,
                                    replacement: Container(
                                        width: 100,
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Icon(
                                            Icons.tv,
                                            color: Colors.black,
                                          ),
                                        )),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      child: AppNetworkImage(
                                          imageUrl:
                                              '${tv.lastEpisodeToAir.stillPath}'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
