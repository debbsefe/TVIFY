import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class GoogleSignInRepository {
  Future<Either<Failure, void>> googleSignInAuth();
}
