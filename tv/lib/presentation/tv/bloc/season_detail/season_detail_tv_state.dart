part of 'season_detail_tv_bloc.dart';

abstract class SeasonDetailTvState extends Equatable {
  const SeasonDetailTvState();
  
  @override
  List<Object> get props => [];
}

class SeasonDetailTvInitial extends SeasonDetailTvState {}

class SeasonDetailTvLoading extends SeasonDetailTvState {}

class SeasonDetailTvLoaded extends SeasonDetailTvState {
  final DetailSeason result;

  const SeasonDetailTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class SeasonDetailTvFailure extends SeasonDetailTvState {
  final String message;

  const SeasonDetailTvFailure(this.message);
}