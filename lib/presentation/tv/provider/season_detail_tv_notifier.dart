import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/detail_season.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:flutter/foundation.dart';

class SeasonDetailTvNotifier extends ChangeNotifier {
  final GetTvDetailSeason getTvDetailSeason;

  SeasonDetailTvNotifier(this.getTvDetailSeason);

  late DetailSeason _season;
  DetailSeason get season => _season;

  String _message = "";
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchSeason(
      {required int tvId, required int seasonNumber}) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvDetailSeason.execute(tvId, seasonNumber);

    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _season = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
