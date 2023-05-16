part of 'watchlist_movie_bloc.dart';

enum WatchlistMovieStatus { initial, loading, success, failure, empty }

enum WatchlistStatus { initial, saved, removed, failure }

class WatchlistMovieState extends Equatable {
  const WatchlistMovieState({
    this.status = WatchlistMovieStatus.initial,
    this.watchlistStatus = WatchlistStatus.initial,
    this.message,
    this.isAddedToWatchlist = false,
    this.watchlistMovies = const [],
  });

  final WatchlistMovieStatus status;
  final WatchlistStatus watchlistStatus;
  final String? message;
  final bool isAddedToWatchlist;
  final List<Movie> watchlistMovies;

  WatchlistMovieState copyWith(
      {WatchlistMovieStatus? status,
      WatchlistStatus? watchlistStatus,
      String? message,
      bool? isAddedToWatchlist,
      List<Movie>? watchlistMovies}) {
    return WatchlistMovieState(
      status: status ?? this.status,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      message: message ?? this.message,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      watchlistMovies: watchlistMovies ?? this.watchlistMovies,
    );
  }

  @override
  List<Object?> get props =>
      [status, watchlistStatus, message, isAddedToWatchlist, watchlistMovies];
}
