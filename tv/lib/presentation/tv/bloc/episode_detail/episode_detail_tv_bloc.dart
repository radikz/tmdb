import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_episode.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_episode.dart';

part 'episode_detail_tv_event.dart';
part 'episode_detail_tv_state.dart';

class EpisodeDetailTvBloc
    extends Bloc<EpisodeDetailTvEvent, EpisodeDetailTvState> {
  EpisodeDetailTvBloc(this._getTvDetailEpisode)
      : super(EpisodeDetailTvInitial()) {
    on<FetchEpisodeDetailTv>((event, emit) async {
      emit(EpisodeDetailTvLoading());
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      final episodeNumber = event.episodeNumber;
      final result =
          await _getTvDetailEpisode.execute(id, seasonNumber, episodeNumber);
      result.fold(
        (failure) {
          emit(EpisodeDetailTvFailure(failure.message));
        },
        (moviesData) {
          emit(EpisodeDetailTvLoaded(moviesData));
        },
      );
    });
  }

  final GetTvDetailEpisode _getTvDetailEpisode;
}
