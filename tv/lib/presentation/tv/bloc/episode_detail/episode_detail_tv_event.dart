part of 'episode_detail_tv_bloc.dart';

abstract class EpisodeDetailTvEvent extends Equatable {
  const EpisodeDetailTvEvent();

  @override
  List<Object> get props => [];
}

class FetchEpisodeDetailTv extends EpisodeDetailTvEvent {
  final int id;
  final int seasonNumber;
  final int episodeNumber;

  const FetchEpisodeDetailTv({
    required this.id,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  @override
  List<Object> get props => [id, seasonNumber, episodeNumber];
}
