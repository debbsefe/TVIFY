import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.message});
  final String? message;
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({this.message}) : super(message: message);
  final String? message;
}

class CacheFailure extends Failure {
  const CacheFailure({this.message}) : super(message: message);
  final String? message;
}

class ConflictFailure extends Failure {
  const ConflictFailure({this.message}) : super(message: message);
  final String? message;
}

class InvalidFailure extends Failure {
  const InvalidFailure({this.message}) : super(message: message);
  final String? message;
}
