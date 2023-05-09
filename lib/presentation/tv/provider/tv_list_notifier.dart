import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:flutter/foundation.dart';

class TvListNotifier extends ChangeNotifier {
  var _airingTodayTvs = <Tv>[];
  List<Tv> get airingTodayTvs => _airingTodayTvs;

  RequestState _airingTodayTvState = RequestState.Empty;
  RequestState get airingTodayTvState => _airingTodayTvState;

  var _popularTvs = <Tv>[];
  List<Tv> get popularTvs => _popularTvs;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTvs = <Tv>[];
  List<Tv> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowAiringTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  final GetNowAiringTvs getNowAiringTvs;
  final GetPopularTvs getPopularTvs;
  final GetTopRatedTvs getTopRatedTvs;

  Future<void> fetchAiringTodayTvs() async {
    _airingTodayTvState = RequestState.Loading;
    notifyListeners();

    final result = await getNowAiringTvs.execute();
    result.fold((failure) {
      _airingTodayTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      print("tada ${data.first.posterPath}");
      _airingTodayTvState = RequestState.Loaded;
      _airingTodayTvs = data;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvs() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold((failure) {
      _popularTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _popularTvState = RequestState.Loaded;
      _popularTvs = data;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold((failure) {
      _topRatedTvState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _topRatedTvState = RequestState.Loaded;
      _topRatedTvs = data;
      notifyListeners();
    });
  }
}
