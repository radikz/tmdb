import 'package:bloc_test/bloc_test.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';

import '../../../helper/dummy.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistMovies, RemoveWatchlist, SaveWatchlist, GetWatchListStatus])
void main() {
  late WatchlistMovieBloc nowPlayingMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    nowPlayingMovieBloc = WatchlistMovieBloc(
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
        getWatchlistMovies: mockGetWatchlistMovies);
  });

  const tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('initial state is state', () {
    expect(nowPlayingMovieBloc.state, const WatchlistMovieState());
  });

  group('Fetching Watchlist Data', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        WatchlistMovieState(
            status: WatchlistMovieStatus.success, watchlistMovies: tMovieList),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Failure] when failure',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(DatabaseFailure("Error")));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovie()),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.failure, message: "Error"),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Success] when there is a watchlist',
      build: () {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(const FetchWatchlistStatusMovie(1)),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.success, isAddedToWatchlist: true),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Success] when adding new data to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("Saved"));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistMovie(testMovieDetail)),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.loading,
            message: "Saved",
            watchlistStatus: WatchlistStatus.saved),
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.success, isAddedToWatchlist: true),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Failure] when failed adding new data to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure("Error")));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistMovie(testMovieDetail)),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.loading,
            message: "Error",
            watchlistStatus: WatchlistStatus.failure),
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(status: WatchlistMovieStatus.success),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Success] when removing watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right("Removed"));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistMovie(testMovieDetail)),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.loading,
            message: "Removed",
            watchlistStatus: WatchlistStatus.removed),
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
          status: WatchlistMovieStatus.success,
          isAddedToWatchlist: true,
        ),
      ],
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'emits [Loading, Failure] when failed to remove the watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure("Error")));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(const RemoveWatchlistMovie(testMovieDetail)),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.loading,
            message: "Error",
            watchlistStatus: WatchlistStatus.failure),
            const WatchlistMovieState(status: WatchlistMovieStatus.loading),
        const WatchlistMovieState(
            status: WatchlistMovieStatus.success,),
      ],
    );
  });
}
