import 'package:bloc/bloc.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  WatchlistMovieBloc(
      {required GetWatchListStatus getWatchListStatus,
      required SaveWatchlist saveWatchlist,
      required RemoveWatchlist removeWatchlist,
      required GetWatchlistMovies getWatchlistMovies})
      : _getWatchListStatus = getWatchListStatus,
        _saveWatchlist = saveWatchlist,
        _removeWatchlist = removeWatchlist,
        _getWatchlistMovies = getWatchlistMovies,
        super(const WatchlistMovieState()) {
    on<FetchWatchlistStatusMovie>(_fetchWatchlistStatusMovie);
    on<RemoveWatchlistMovie>(_removeWatchlistMovie);
    on<AddWatchlistMovie>(_addWatchlistMovie);
    on<FetchWatchlistMovie>(_fetchWatchlistMovie);
  }

  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchlistMovies _getWatchlistMovies;

  Future<void> _removeWatchlistMovie(
    RemoveWatchlistMovie event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(state.copyWith(status: WatchlistMovieStatus.loading));
    final result = await _removeWatchlist.execute(event.details);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
            message: failure.message,
            watchlistStatus: WatchlistStatus.failure));
      },
      (successMessage) async {
        emit(state.copyWith(
            message: successMessage, watchlistStatus: WatchlistStatus.removed));
      },
    );
    add(FetchWatchlistStatusMovie(event.details.id));
  }

  Future<void> _fetchWatchlistMovie(
    FetchWatchlistMovie event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(const WatchlistMovieState(status: WatchlistMovieStatus.loading));
    final result = await _getWatchlistMovies.execute();

    await result.fold(
      (failure) async {
        emit(state.copyWith(
            message: failure.message, status: WatchlistMovieStatus.failure));
      },
      (data) async {
        if (data.isEmpty) {
          emit(state.copyWith(status: WatchlistMovieStatus.empty));
          return;
        }
        emit(state.copyWith(
            watchlistMovies: data, status: WatchlistMovieStatus.success));
      },
    );
  }

  Future<void> _addWatchlistMovie(
    AddWatchlistMovie event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(state.copyWith(status: WatchlistMovieStatus.loading));
    final result = await _saveWatchlist.execute(event.details);

    await result.fold(
      (failure) async {
        emit(state.copyWith(
            message: failure.message,
            watchlistStatus: WatchlistStatus.failure));
      },
      (successMessage) async {
        emit(state.copyWith(
            message: successMessage, watchlistStatus: WatchlistStatus.saved));
      },
    );
    add(FetchWatchlistStatusMovie(event.details.id));
  }

  Future<void> _fetchWatchlistStatusMovie(
    FetchWatchlistStatusMovie event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    emit(const WatchlistMovieState(status: WatchlistMovieStatus.loading));
    final result = await _getWatchListStatus.execute(event.id);
      emit(state.copyWith(
          isAddedToWatchlist: result, status: WatchlistMovieStatus.success));
  }
}
