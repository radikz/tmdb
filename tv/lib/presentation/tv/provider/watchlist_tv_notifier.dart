import 'package:core/utils/state_enum.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tvs.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvNotifier(this.getWatchlistTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = <Tv>[];
  List<Tv> get tvs => _tvs;

  String _message = "";
  String get message => _message;

  Future<void> fetchWatchlistTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvs.execute();
    result.fold((failure) {
      _state = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (data) {
      _state = RequestState.Loaded;
      _tvs = data;
      notifyListeners();
    });
  }
}
