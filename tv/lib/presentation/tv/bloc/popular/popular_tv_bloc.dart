import 'package:bloc/bloc.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_popular_tvs.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  PopularTvBloc(this._getPopularTvs) : super(PopularTvInitial()) {
    on<FetchPopularTv>((event, emit) async {
      emit(PopularTvLoading());
      final result = await _getPopularTvs.execute();
      result.fold(
        (failure) {
          emit(PopularTvFailure(failure.message));
        },
        (moviesData) {
          emit(PopularTvLoaded(moviesData));
        },
      );
    });
  }

  final GetPopularTvs _getPopularTvs;
}
