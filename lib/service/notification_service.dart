import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging;

  NotificationService(this._firebaseMessaging);

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    _firebaseMessaging.setAutoInitEnabled(true);
  }
}
