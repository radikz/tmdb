part of 'watchlist_tv_bloc.dart';

enum WatchlistTvStatus { initial, loading, success, failure, empty }

enum WatchlistStatus { initial, saved, removed, failure }

class WatchlistTvState extends Equatable {
  const WatchlistTvState({
    this.status = WatchlistTvStatus.initial,
    this.watchlistStatus = WatchlistStatus.initial,
    this.message,
    this.isAddedToWatchlist = false,
    this.watchlistTvs = const [],
  });

  final WatchlistTvStatus status;
  final WatchlistStatus watchlistStatus;
  final String? message;
  final bool isAddedToWatchlist;
  final List<Tv> watchlistTvs;

  WatchlistTvState copyWith(
      {WatchlistTvStatus? status,
      WatchlistStatus? watchlistStatus,
      String? message,
      bool? isAddedToWatchlist,
      List<Tv>? watchlistTvs}) {
    return WatchlistTvState(
      status: status ?? this.status,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistTvs: watchlistTvs ?? this.watchlistTvs,
    );
  }

  @override
  List<Object?> get props =>
      [status, watchlistStatus, message, isAddedToWatchlist, watchlistTvs];
}
