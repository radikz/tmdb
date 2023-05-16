import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/presentation/tv/provider/episode_detail_tv_notifier.dart';

class TvDetailEpisodePage extends StatefulWidget {
  const TvDetailEpisodePage({Key? key, required this.arg}) : super(key: key);

  final TvDetailEpisodeArg arg;

  @override
  State<TvDetailEpisodePage> createState() => _TvDetailEpisodePageState();
}

class _TvDetailEpisodePageState extends State<TvDetailEpisodePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<EpisodeDetailTvNotifier>().fetchEpisode(
        tvId: widget.arg.tvId,
        seasonNumber: widget.arg.seasonNumber,
        episodeNumber: widget.arg.episodeNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Episode"),
      ),
      body: SafeArea(child: Consumer<EpisodeDetailTvNotifier>(
          builder: (context, provider, child) {
        if (provider.state == RequestState.Loaded) {
          return DetailContentEpisode(episode: provider.episodes);
        } else if (provider.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Text(
          provider.message,
          key: ValueKey("__episode_error__tv"),
        );
      })),
    );
  }
}

class DetailContentEpisode extends StatelessWidget {
  const DetailContentEpisode({Key? key, required this.episode})
      : super(key: key);

  final TvEpisode episode;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Visibility(
          visible: episode.stillPath != null,
          child: AppNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
            width: screenWidth,
          ),
          replacement: Container(
              width: screenWidth,
              color: Colors.grey,
              child: Center(
                child: Icon(
                  Icons.movie,
                  color: Colors.black,
                ),
              )),
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          episode.name,
          style: kHeading5,
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: episode.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text('${episode.voteAverage}')
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          'Overview',
          style: kHeading6,
        ),
        Text(
          episode.overview,
        ),
      ]),
    );
  }
}

class TvDetailEpisodeArg {
  final int tvId;
  final int seasonNumber;
  final int episodeNumber;

  TvDetailEpisodeArg({
    required this.tvId,
    required this.seasonNumber,
    required this.episodeNumber,
  });
}
