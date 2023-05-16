import 'package:core/movie/domain/entities/genre.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
    context
        .read<WatchlistMovieBloc>()
        .add(FetchWatchlistStatusMovie(widget.id));
    context
        .read<RecommendationMovieBloc>()
        .add(FetchRecommendationMovie(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistMovieBloc, WatchlistMovieState>(
      listener: (context, state) {
        final message = state.message;
        if (state.message != null) {
          if (message == watchlistAddSuccessMessage ||
              message == watchlistRemoveSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(key: ValueKey("watchlist_movie_snackbar"), content: Text(message!)));
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    key: ValueKey("watchlist_movie_error_alert_dialog"),
                    content: Text(message!),
                  );
                });
          }
        }
      },
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailLoaded) {
              final movie = state.result;
              return SafeArea(
                child: DetailContent(
                  movie,
                ),
              );
            } else if (state is MovieDetailFailure) {
              return Text(state.message);
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  const DetailContent(this.movie);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AppNetworkImage(
          imageUrl: movie.posterPath,
          width: screenWidth,
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                        key: ValueKey("detail_scrollview"),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              key: ValueKey("watchlist_movie_button"),
                              onPressed: () async {
                                final isAddedWatchlist = context
                                    .read<WatchlistMovieBloc>()
                                    .state
                                    .isAddedToWatchlist;

                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(AddWatchlistMovie(movie));
                                } else {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(RemoveWatchlistMovie(movie));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BlocBuilder<WatchlistMovieBloc,
                                      WatchlistMovieState>(
                                    builder: (context, state) {
                                      final isAddedWatchlist =
                                          state.isAddedToWatchlist;
                                      return isAddedWatchlist
                                          ? Icon(Icons.check, key: Key("movie_detail_icon_check"),)
                                          : Icon(Icons.add);
                                    },
                                  ),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              key: ValueKey("__detail_recommendation_text__"),
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMovieBloc, RecommendationMovieState>(
                              builder: (context, state) {
                                if (state is RecommendationMovieLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      key: ValueKey(
                                          "__recommendation_loading__"),
                                    ),
                                  );
                                } else if (state is RecommendationMovieFailure) {
                                  return Text(state.message,
                                      key:
                                          ValueKey("__recommendation_error__"));
                                } else if (state is RecommendationMovieLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            key: ValueKey(
                                                "__recommendation_inkwell__"),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                movieDetailRoute,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: AppNetworkImage(
                                                  imageUrl:
                                                      '${movie.posterPath}'),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    key: ValueKey("__recommendation_empty__"),
                                  );
                                }
                              },
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
              icon: Icon(Icons.arrow_back),
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
      result += genre.name + ', ';
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
