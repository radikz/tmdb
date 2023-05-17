import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(OnQueryChanged("test"), OnQueryChanged("test"));
  });
}
