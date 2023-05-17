import 'package:bloc/bloc.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tv/save_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  WatchlistTvBloc(
      {required GetTvWatchlistStatus getWatchListStatus,
      required SaveWatchlistTv saveWatchlist,
      required RemoveWatchlistTv removeWatchlist,
      required GetWatchlistTvs getWatchlistTvs})
      : _getWatchListStatus = getWatchListStatus,
        _saveWatchlist = saveWatchlist,
        _removeWatchlist = removeWatchlist,
        _getWatchlistTvs = getWatchlistTvs,
        super(WatchlistTvState()) {
    on<FetchWatchlistStatusTv>(_fetchWatchlistStatusTv);
    on<RemoveWatchlistTvEvent>(_removeWatchlistTv);
    on<AddWatchlistTv>(_addWatchlistTv);
    on<FetchWatchlistTv>(_fetchWatchlistTv);
  }

  final GetTvWatchlistStatus _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;
  final GetWatchlistTvs _getWatchlistTvs;

  Future<void> _removeWatchlistTv(
    RemoveWatchlistTvEvent event,
    Emitter<WatchlistTvState> emit,
  ) async {
    emit(state.copyWith(status: WatchlistTvStatus.loading));
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
    add(FetchWatchlistStatusTv(event.details.id));
  }

  Future<void> _fetchWatchlistTv(
    FetchWatchlistTv event,
    Emitter<WatchlistTvState> emit,
  ) async {
    emit(WatchlistTvState(status: WatchlistTvStatus.loading));
    final result = await _getWatchlistTvs.execute();

    await result.fold(
      (failure) async {
        emit(state.copyWith(
            message: failure.message, status: WatchlistTvStatus.failure));
      },
      (data) async {
        if (data.isEmpty) {
          emit(state.copyWith(status: WatchlistTvStatus.empty));
          return;
        }
        emit(state.copyWith(
            watchlistTvs: data, status: WatchlistTvStatus.success));
      },
    );
  }

  Future<void> _addWatchlistTv(
    AddWatchlistTv event,
    Emitter<WatchlistTvState> emit,
  ) async {
    emit(state.copyWith(status: WatchlistTvStatus.loading));
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
    add(FetchWatchlistStatusTv(event.details.id));
  }

  Future<void> _fetchWatchlistStatusTv(
    FetchWatchlistStatusTv event,
    Emitter<WatchlistTvState> emit,
  ) async {
    emit(WatchlistTvState(status: WatchlistTvStatus.loading));
    final result = await _getWatchListStatus.execute(event.id);
    emit(state.copyWith(
        isAddedToWatchlist: result, status: WatchlistTvStatus.success));
  }
}
