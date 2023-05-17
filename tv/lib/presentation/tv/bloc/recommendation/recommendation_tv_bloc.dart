import 'package:bloc/bloc.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/tv/get_tvs_recommendation.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  RecommendationTvBloc(this._getTvsRecommendation)
      : super(RecommendationTvInitial()) {
    on<FetchRecommendationTv>((event, emit) async {
      emit(RecommendationTvLoading());
      final id = event.id;
      final result = await _getTvsRecommendation.execute(id);
      result.fold(
        (failure) {
          emit(RecommendationTvFailure(failure.message));
        },
        (movies) {
          if (movies.isEmpty) {
            emit(RecommendationTvEmpty());
            return;
          }
          emit(RecommendationTvLoaded(movies));
        },
      );
    });
  }

  final GetTvsRecommendation _getTvsRecommendation;
}
