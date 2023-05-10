import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:flutter/foundation.dart';


class AiringNowTvsNotifier extends ChangeNotifier {
  final GetNowAiringTvs getNowAiringTvs;

  AiringNowTvsNotifier(this.getNowAiringTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tv => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchAiringNowTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowAiringTvs.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (data) {
      _tvs = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
