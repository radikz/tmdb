import 'package:bloc/bloc.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(RecommendationMovieInitial()) {
    on<FetchRecommendationMovie>((event, emit) async {
      emit(RecommendationMovieLoading());
      final id = event.id;
      final result = await _getMovieRecommendations.execute(id);
      result.fold(
        (failure) {
          emit(RecommendationMovieFailure(failure.message));
        },
        (movies) {
          if (movies.isEmpty) {
            emit(RecommendationMovieEmpty());
            return;
          }
          emit(RecommendationMovieLoaded(movies));
        },
      );
    });
  }

  final GetMovieRecommendations _getMovieRecommendations;
}
