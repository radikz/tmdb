import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/app_network_image.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/presentation/tv/pages/tv_detail_episode_page.dart';
import 'package:ditonton/presentation/tv/provider/season_detail_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TvSeasonPage extends StatefulWidget {
  const TvSeasonPage({Key? key, required this.arg}) : super(key: key);

  final TvSeasonArg arg;

  

  @override
  State<TvSeasonPage> createState() => _TvDetailEpisodePageState();
}

class _TvDetailEpisodePageState extends State<TvSeasonPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<SeasonDetailTvNotifier>().fetchSeason(
        tvId: widget.arg.tvId, seasonNumber: widget.arg.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Season"),
      ),
      body: SafeArea(child:
          Consumer<SeasonDetailTvNotifier>(builder: (context, provider, child) {
        if (provider.state == RequestState.Loaded) {
          print("data ${provider.season.name}");
          return ListView.builder(
            itemBuilder: (context, index) {
              return SeasonContent(
                episode: provider.season.episodes[index],
                tvId: widget.arg.tvId,
              );
            },
            itemCount: provider.season.episodes.length,
          );
        } else if (provider.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Text(
          provider.message,
          key: ValueKey("__season_error__tv"),
        );
      })),
    );
  }
}

class SeasonContent extends StatelessWidget {
  final TvEpisode episode;
  final int tvId;

  SeasonContent({required this.episode, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            tvDetailEpisodeRoute,
            arguments: TvDetailEpisodeArg(
                tvId: tvId,
                seasonNumber: episode.seasonNumber,
                episodeNumber: episode.episodeNumber),
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      episode.overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: Visibility(
                  visible: episode.stillPath != null,
                  replacement: Container(
                      width: 80,
                      height: 100,
                      color: Colors.grey,
                      child: Center(
                        child: Icon(
                          Icons.movie,
                          color: Colors.black,
                        ),
                      )),
                  child: AppNetworkImage(
                    imageUrl: '${episode.stillPath}',
                    width: 80,
                    height: 100,
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TvSeasonArg {
  final int tvId;
  final int seasonNumber;

  TvSeasonArg({
    required this.tvId,
    required this.seasonNumber,
  });
}
