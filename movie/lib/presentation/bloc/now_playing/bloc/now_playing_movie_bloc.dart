import 'package:bloc/bloc.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieInitial()) {
    on<FetchNowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());

      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(NowPlayingMovieFailure(failure.message));
        },
        (moviesData) {
          emit(NowPlayingMovieLoaded(moviesData));
        },
      );
    });
  }

  final GetNowPlayingMovies _getNowPlayingMovies;
}
