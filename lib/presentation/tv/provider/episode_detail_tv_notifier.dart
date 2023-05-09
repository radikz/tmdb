import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_episode.dart';
import 'package:flutter/foundation.dart';

class EpisodeDetailTvNotifier extends ChangeNotifier {
  final GetTvDetailEpisode getTvDetailEpisode;

  EpisodeDetailTvNotifier(this.getTvDetailEpisode);

  late TvEpisode _episodes;
  TvEpisode get episodes => _episodes;

  String _message = "";
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchEpisode(
      {required int tvId,
      required int seasonNumber,
      required int episodeNumber}) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result =
        await getTvDetailEpisode.execute(tvId, seasonNumber, episodeNumber);

    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _episodes = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
