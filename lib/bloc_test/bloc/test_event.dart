part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

final class CounterIncrementPressed extends TestEvent {}
