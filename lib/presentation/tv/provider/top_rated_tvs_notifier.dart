import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/tv.dart';

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
