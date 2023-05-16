part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistStatusMovie extends WatchlistMovieEvent {
  final int id;

  const FetchWatchlistStatusMovie(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail details;

  const RemoveWatchlistMovie(this.details);

  @override
  List<Object> get props => [details];
}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail details;

  const AddWatchlistMovie(this.details);

  @override
  List<Object> get props => [details];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {}
