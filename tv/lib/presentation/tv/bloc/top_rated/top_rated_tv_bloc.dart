import 'package:bloc/bloc.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tvs.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  TopRatedTvBloc(this._getTopRatedTvs) : super(TopRatedTvInitial()) {
    on<FetchTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());

      final result = await _getTopRatedTvs.execute();
      result.fold(
        (failure) {
          emit(TopRatedTvFailure(failure.message));
        },
        (moviesData) {
          emit(TopRatedTvLoaded(moviesData));
        },
      );
    });
  }

  final GetTopRatedTvs _getTopRatedTvs;
}
