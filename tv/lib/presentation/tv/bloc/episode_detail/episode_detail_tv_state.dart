part of 'episode_detail_tv_bloc.dart';

abstract class EpisodeDetailTvState extends Equatable {
  const EpisodeDetailTvState();
  
  @override
  List<Object> get props => [];
}

class EpisodeDetailTvInitial extends EpisodeDetailTvState {}

class EpisodeDetailTvLoading extends EpisodeDetailTvState {}

class EpisodeDetailTvLoaded extends EpisodeDetailTvState {
  final TvEpisode result;

  const EpisodeDetailTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class EpisodeDetailTvFailure extends EpisodeDetailTvState {
  final String message;

  const EpisodeDetailTvFailure(this.message);
}