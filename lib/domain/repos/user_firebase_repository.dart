// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:summarator/common/errors/failure.dart';

abstract class IUserFirebaseRepository {
  Future<Either<Failure, UserCredential>> signInWithCredential(
      {required Map payload});
}
