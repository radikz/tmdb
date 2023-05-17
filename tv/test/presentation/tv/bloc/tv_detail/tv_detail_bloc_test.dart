import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/presentation/tv/bloc/tv_detail/tv_detail_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetails;

  setUp(() {
    mockGetTvDetails = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetails);
  });

  test('initial state is initial', () {
    expect(tvDetailBloc.state, TvDetailInitial());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvDetails.execute(1))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(1)),
    expect: () => <TvDetailState>[
      TvDetailLoading(),
      TvDetailLoaded(testTvDetail),
    ],
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [Loading, Failure] when failure',
    build: () {
      when(mockGetTvDetails.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure("Error")));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(1)),
    expect: () => <TvDetailState>[
      TvDetailLoading(),
      const TvDetailFailure("Error"),
    ],
  );
}
