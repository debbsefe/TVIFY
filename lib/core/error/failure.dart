import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure({this.properties = const <dynamic>[]}) : super();

  @override
  List<Object> get props => [properties];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
