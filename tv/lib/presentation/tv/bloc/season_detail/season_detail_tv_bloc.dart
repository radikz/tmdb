import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/detail_season.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season.dart';

part 'season_detail_tv_event.dart';
part 'season_detail_tv_state.dart';

class SeasonDetailTvBloc
    extends Bloc<SeasonDetailTvEvent, SeasonDetailTvState> {
  SeasonDetailTvBloc(this._getTvDetailSeason) : super(SeasonDetailTvInitial()) {
    on<FetchSeasonDetailTv>((event, emit) async {
      emit(SeasonDetailTvLoading());
      final id = event.id;
      final seasonNumber = event.seasonNumber;
      final result = await _getTvDetailSeason.execute(id, seasonNumber);
      result.fold(
        (failure) {
          emit(SeasonDetailTvFailure(failure.message));
        },
        (moviesData) {
          emit(SeasonDetailTvLoaded(moviesData));
        },
      );
    });
  }

  final GetTvDetailSeason _getTvDetailSeason;
}
