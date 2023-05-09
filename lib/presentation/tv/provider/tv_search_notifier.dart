import 'package:core/utils/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvs searchTvs;

  TvSearchNotifier(this.searchTvs);

  RequestState _state = RequestState.Initial;
  RequestState get state => _state;

  List<Tv> _tvs = [];
  List<Tv> get tv => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> search(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvs.execute(query);

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (data) {
      if (data.isEmpty) {
        _state = RequestState.Empty;
      } else {
        _tvs = data;
        _state = RequestState.Loaded;
      }
      notifyListeners();
    });
  }
}
