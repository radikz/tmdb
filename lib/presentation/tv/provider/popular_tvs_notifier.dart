import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/tv.dart';

class PopularTvsNotifier extends ChangeNotifier {
  final GetPopularTvs getPopularTvs;

  PopularTvsNotifier(this.getPopularTvs);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tv => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvs.execute();

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
