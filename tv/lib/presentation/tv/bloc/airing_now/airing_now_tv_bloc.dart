import 'package:bloc/bloc.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';

part 'airing_now_tv_event.dart';
part 'airing_now_tv_state.dart';

class AiringNowTvBloc extends Bloc<AiringNowTvEvent, AiringNowTvState> {
  AiringNowTvBloc(this._getNowAiringTvs) : super(AiringNowTvInitial()) {
    on<FetchAiringNowTv>((event, emit) async {
      emit(AiringNowTvLoading());

      final result = await _getNowAiringTvs.execute();
      result.fold(
        (failure) {
          emit(AiringNowTvFailure(failure.message));
        },
        (moviesData) {
          emit(AiringNowTvLoaded(moviesData));
        },
      );
    });
  }

  final GetNowAiringTvs _getNowAiringTvs;
}
