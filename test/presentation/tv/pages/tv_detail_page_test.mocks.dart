// Mocks generated by Mockito 5.4.0 from annotations
// in ditonton/test/presentation/tv/pages/tv_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv.dart' as _i10;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/tv/get_tv_watchlist_status.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv/get_tvs_recommendation.dart' as _i3;
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart' as _i6;
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart' as _i5;
import 'package:ditonton/presentation/tv/provider/tv_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetTvDetail_0 extends _i1.SmartFake implements _i2.GetTvDetail {
  _FakeGetTvDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTvsRecommendation_1 extends _i1.SmartFake
    implements _i3.GetTvsRecommendation {
  _FakeGetTvsRecommendation_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTvWatchlistStatus_2 extends _i1.SmartFake
    implements _i4.GetTvWatchlistStatus {
  _FakeGetTvWatchlistStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveWatchlistTv_3 extends _i1.SmartFake
    implements _i5.SaveWatchlistTv {
  _FakeSaveWatchlistTv_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveWatchlistTv_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlistTv {
  _FakeRemoveWatchlistTv_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvDetail_5 extends _i1.SmartFake implements _i7.TvDetail {
  _FakeTvDetail_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TvDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDetailNotifier extends _i1.Mock implements _i8.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail => (super.noSuchMethod(
        Invocation.getter(#getTvDetail),
        returnValue: _FakeGetTvDetail_0(
          this,
          Invocation.getter(#getTvDetail),
        ),
      ) as _i2.GetTvDetail);
  @override
  _i3.GetTvsRecommendation get getTvsRecommendation => (super.noSuchMethod(
        Invocation.getter(#getTvsRecommendation),
        returnValue: _FakeGetTvsRecommendation_1(
          this,
          Invocation.getter(#getTvsRecommendation),
        ),
      ) as _i3.GetTvsRecommendation);
  @override
  _i4.GetTvWatchlistStatus get getTvWatchlistStatus => (super.noSuchMethod(
        Invocation.getter(#getTvWatchlistStatus),
        returnValue: _FakeGetTvWatchlistStatus_2(
          this,
          Invocation.getter(#getTvWatchlistStatus),
        ),
      ) as _i4.GetTvWatchlistStatus);
  @override
  _i5.SaveWatchlistTv get saveWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#saveWatchlistTv),
        returnValue: _FakeSaveWatchlistTv_3(
          this,
          Invocation.getter(#saveWatchlistTv),
        ),
      ) as _i5.SaveWatchlistTv);
  @override
  _i6.RemoveWatchlistTv get removeWatchlistTv => (super.noSuchMethod(
        Invocation.getter(#removeWatchlistTv),
        returnValue: _FakeRemoveWatchlistTv_4(
          this,
          Invocation.getter(#removeWatchlistTv),
        ),
      ) as _i6.RemoveWatchlistTv);
  @override
  _i7.TvDetail get tvDetail => (super.noSuchMethod(
        Invocation.getter(#tvDetail),
        returnValue: _FakeTvDetail_5(
          this,
          Invocation.getter(#tvDetail),
        ),
      ) as _i7.TvDetail);
  @override
  _i9.RequestState get tvState => (super.noSuchMethod(
        Invocation.getter(#tvState),
        returnValue: _i9.RequestState.Empty,
      ) as _i9.RequestState);
  @override
  List<_i10.Tv> get tvRecommendations => (super.noSuchMethod(
        Invocation.getter(#tvRecommendations),
        returnValue: <_i10.Tv>[],
      ) as List<_i10.Tv>);
  @override
  _i9.RequestState get recommendationState => (super.noSuchMethod(
        Invocation.getter(#recommendationState),
        returnValue: _i9.RequestState.Empty,
      ) as _i9.RequestState);
  @override
  String get message => (super.noSuchMethod(
        Invocation.getter(#message),
        returnValue: '',
      ) as String);
  @override
  bool get isAddedToWatchlist => (super.noSuchMethod(
        Invocation.getter(#isAddedToWatchlist),
        returnValue: false,
      ) as bool);
  @override
  String get watchlistMessage => (super.noSuchMethod(
        Invocation.getter(#watchlistMessage),
        returnValue: '',
      ) as String);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i11.Future<void> fetchTvDetail(int? id) => (super.noSuchMethod(
        Invocation.method(
          #fetchTvDetail,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlist(_i7.TvDetail? tv) => (super.noSuchMethod(
        Invocation.method(
          #addWatchlist,
          [tv],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [tv],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  _i11.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
        Invocation.method(
          #loadWatchlistStatus,
          [id],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i12.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
