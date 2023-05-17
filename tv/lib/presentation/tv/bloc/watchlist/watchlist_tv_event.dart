part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistStatusTv extends WatchlistTvEvent {
  final int id;

  const FetchWatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveWatchlistTvEvent extends WatchlistTvEvent {
  final TvDetail details;

  const RemoveWatchlistTvEvent(this.details);

  @override
  List<Object> get props => [details];
}

class AddWatchlistTv extends WatchlistTvEvent {
  final TvDetail details;

  const AddWatchlistTv(this.details);

  @override
  List<Object> get props => [details];
}

class FetchWatchlistTv extends WatchlistTvEvent {}