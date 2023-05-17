import 'package:bloc_test/bloc_test.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';


@GenerateMocks(
    [GetWatchlistTvs, RemoveWatchlistTv, SaveWatchlistTv, GetTvWatchlistStatus])
void main() {
  late WatchlistTvBloc nowPlayingMovieBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late MockGetTvWatchlistStatus mockGetTvWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    mockGetTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    nowPlayingMovieBloc = WatchlistTvBloc(
        getWatchListStatus: mockGetTvWatchlistStatus,
        saveWatchlist: mockSaveWatchlistTv,
        removeWatchlist: mockRemoveWatchlistTv,
        getWatchlistTvs: mockGetWatchlistTvs);
  });


  final testTvList = <Tv>[testTv];

  test('initial state is state', () {
    expect(nowPlayingMovieBloc.state, WatchlistTvState());
  });

  group('Fetching Watchlist Data', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.success, watchlistTvs: testTvList),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Failure] when failure',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Error")));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistTv()),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.failure, message: "Error"),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Success] when there is a watchlist',
      build: () {
        when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistStatusTv(1)),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.success, isAddedToWatchlist: true),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Success] when adding new data to watchlist',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right("Saved"));
        when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.loading,
            message: "Saved",
            watchlistStatus: WatchlistStatus.saved),
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.success, isAddedToWatchlist: true),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Failure] when failed adding new data to watchlist',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure("Error")));
        when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => false);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.loading,
            message: "Error",
            watchlistStatus: WatchlistStatus.failure),
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(status: WatchlistTvStatus.success),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Success] when removing watchlist',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right("Removed"));
        when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTvEvent(testTvDetail)),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.loading,
            message: "Removed",
            watchlistStatus: WatchlistStatus.removed),
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
          status: WatchlistTvStatus.success,
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'emits [Loading, Failure] when failed to remove the watchlist',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure("Error")));
        when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => false);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTvEvent(testTvDetail)),
      expect: () => <WatchlistTvState>[
        WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.loading,
            message: "Error",
            watchlistStatus: WatchlistStatus.failure),
            WatchlistTvState(status: WatchlistTvStatus.loading),
        WatchlistTvState(
            status: WatchlistTvStatus.success,),
      ],
    );
  });
}
