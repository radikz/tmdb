import 'package:flutter_test/flutter_test.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(const OnQueryChanged("test"), const OnQueryChanged("test"));
  });
}
