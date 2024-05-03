part of 'test_bloc.dart';

@immutable
sealed class TestState {}

final class TestInitial extends TestState {
  final int counter;

  TestInitial(this.counter);
}
