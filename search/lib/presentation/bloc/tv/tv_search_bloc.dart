import 'package:bloc/bloc.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tvs.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  TvSearchBloc(this._searchTvs) : super(TvSearchInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(TvSearchLoading());

      final result = await _searchTvs.execute(query);

      result.fold((failure) {
        emit(TvSearchError(failure.message));
      }, (data) {
        if (data.isEmpty) {
          emit(TvSearchEmpty());
        } else {
          emit(TvSearchHasData(data));
        }
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  final SearchTvs _searchTvs;
}
