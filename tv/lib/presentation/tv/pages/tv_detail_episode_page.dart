import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/presentation/tv/bloc/episode_detail/episode_detail_tv_bloc.dart';

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
    context.read<EpisodeDetailTvBloc>().add(FetchEpisodeDetailTv(
        id: widget.arg.tvId,
        seasonNumber: widget.arg.seasonNumber,
        episodeNumber: widget.arg.episodeNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Episode"),
      ),
      body: SafeArea(
          child: BlocBuilder<EpisodeDetailTvBloc, EpisodeDetailTvState>(
        builder: (context, state) {
          if (state is EpisodeDetailTvLoaded) {
            return DetailContentEpisode(episode: state.result);
          } else if (state is EpisodeDetailTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EpisodeDetailTvFailure) {
            return Text(
              state.message,
              key: const ValueKey("__episode_error__tv"),
            );
          } else {
            return const SizedBox();
          }
        },
      )),
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
          replacement: Container(
              width: screenWidth,
              color: Colors.grey,
              child: const Center(
                child: Icon(
                  Icons.movie,
                  color: Colors.black,
                ),
              )),
          child: AppNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
            width: screenWidth,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          episode.name,
          style: kHeading5,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            RatingBarIndicator(
              rating: episode.voteAverage / 2,
              itemCount: 5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: kMikadoYellow,
              ),
              itemSize: 24,
            ),
            Text('${episode.voteAverage}')
          ],
        ),
        const SizedBox(
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
