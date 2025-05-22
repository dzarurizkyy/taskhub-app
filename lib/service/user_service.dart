import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhub_app/models/user.dart';
import 'package:taskhub_app/service/auth_service.dart' as auth;

class UserService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userAuth = auth.AuthService();

  Future<Map<String, dynamic>?> fetchUserById(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("user")
        .where("id", isEqualTo: id)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return null;

    return snapshot.docs.first.data();
  }

  Future<String?> createUser(User req) async {
    CollectionReference user = firestore.collection("user");

    try {
      DocumentReference docRef = await user.add({
        "id": req.id,
        "name": req.name,
        "gender": req.gender,
        "email": req.email,
        "password": req.password,
        "created_at": DateTime.now(),
        "updated_at": DateTime.now(),
      });
      return docRef.id;
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateUser(User req) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("user")
          .where("id", isEqualTo: req.id)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception("User not found");
      }

      final docId = querySnapshot.docs.first.id;

      await FirebaseFirestore.instance.collection("user").doc(docId).update({
        "name": req.name,
        "gender": req.gender,
        "email": req.email,
        "password": req.password,
        "updated_at": DateTime.now()
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
