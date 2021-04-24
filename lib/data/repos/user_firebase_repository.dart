import 'package:injectable/injectable.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:summarator/common/errors/no_connection.dart';
import 'package:summarator/common/utils/network_check.dart';
import 'package:summarator/data/datasource/firebase_auth_datasource.dart';
import 'package:summarator/domain/repos/user_firebase_repository.dart';

@LazySingleton(as: IUserFirebaseRepository)
class UserFireBaseRepository implements IUserFirebaseRepository {
  final NetworkCheck networkCheck;
  final FirebaseAuthDatasource firebaseAuthDatasource;

  UserFireBaseRepository({
    required this.networkCheck,
    required this.firebaseAuthDatasource,
  });
  @override
  Future<Either<Failure, UserCredential>> signInWithCredential(
      {required Map payload}) async {
    if (await networkCheck.isOnline()) {
      final result =
          await firebaseAuthDatasource.signInWithCredential(payload: payload);
      return Right(result);
    } else {
      return Left(NoConnectionError());
    }
  }
}
