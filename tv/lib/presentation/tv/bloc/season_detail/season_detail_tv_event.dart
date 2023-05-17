part of 'season_detail_tv_bloc.dart';

abstract class SeasonDetailTvEvent extends Equatable {
  const SeasonDetailTvEvent();

  @override
  List<Object> get props => [];
}

class FetchSeasonDetailTv extends SeasonDetailTvEvent {
  final int id;
  final int seasonNumber;

  const FetchSeasonDetailTv({
    required this.id,
    required this.seasonNumber,
  });

  @override
  List<Object> get props => [id, seasonNumber];
}
