import 'package:bloc_test/bloc_test.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:tv/domain/usecases/tv/get_tvs_recommendation.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/recommendation/recommendation_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvsRecommendation])
void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvsRecommendation mockGetRecommendationTvs;

  setUp(() {
    mockGetRecommendationTvs = MockGetTvsRecommendation();
    recommendationTvBloc = RecommendationTvBloc(mockGetRecommendationTvs);
  });

  final tTvList = <Tv>[testTv];

  test('initial state is initial', () {
    expect(recommendationTvBloc.state, RecommendationTvInitial());
  });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetRecommendationTvs.execute(1))
          .thenAnswer((_) async => Right(tTvList));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationTv(1)),
    expect: () => <RecommendationTvState>[
      RecommendationTvLoading(),
      RecommendationTvLoaded(tTvList),
    ],
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetRecommendationTvs.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Error")));
      return recommendationTvBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationTv(1)),
    expect: () => <RecommendationTvState>[
      RecommendationTvLoading(),
      RecommendationTvFailure("Error"),
    ],
  );
}
