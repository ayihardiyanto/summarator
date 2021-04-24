// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:summarator/common/errors/failure.dart';
import 'package:summarator/common/usecase/usecase.dart';
import 'package:summarator/domain/repos/user_firebase_repository.dart';

class UserSignInWithCredentialUseCase implements Usecase<UserCredential, Map> {
  final IUserFirebaseRepository userRepository;

  UserSignInWithCredentialUseCase({required this.userRepository});

  @override
  Future<Either<Failure, UserCredential>> call(Map payload) async {
    return await userRepository.signInWithCredential(payload: payload);
  }
}
