import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:taskhub_app/models/user.dart' as local_user;

class AuthService {
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;
  
  Stream<local_user.User?> get streamAuthStatus {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) {
        return null;
      }

      return local_user.User(
        id: user.uid,
        name: null,
        gender: null,
        email: user.email ?? "",
        password: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    });
  }

  Future<String> register(String email, String password) async {
    try {
      final fb.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid ?? "";
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String> login(String email, String password) async {
    try {
      fb.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final fb.User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception("User not found");
      }

      return firebaseUser.uid;
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  void logout() async {
    await _firebaseAuth.signOut();
  }
}
