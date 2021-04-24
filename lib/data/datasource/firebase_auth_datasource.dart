import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class IFirebaseAuthDatasource {
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);
  Future<UserCredential> signInWithCredential({required Map payload});
  Future<int> signOut();
  Future<String> isSignedIn();
  Future<String> getUser();
}

@LazySingleton(as: IFirebaseAuthDatasource)
class FirebaseAuthDatasource implements IFirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDatasource({
    required this.firebaseAuth,
  });

  @override
  Future<String> getUser() async {
    return (firebaseAuth.currentUser)!.email!;
  }

  @override
  Future<String> isSignedIn() async {
    final currentUser = firebaseAuth.currentUser;
    return currentUser!.email!;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result;
  }

  @override
  Future<int> signOut() async {
    try {
      await firebaseAuth.signOut();
      return 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithCredential({required Map payload}) async {
    String email = payload['email'];
    String password = payload['password'];
    UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result;
  }
}
