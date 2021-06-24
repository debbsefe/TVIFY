import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class AnonymousSignInRepository {
  Future<Either<Failure, void>> anonymousSignInAuth();
}
