import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tvs.dart';


class TopRatedTvsNotifier extends ChangeNotifier {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvsNotifier(this.getTopRatedTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tv => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();

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
