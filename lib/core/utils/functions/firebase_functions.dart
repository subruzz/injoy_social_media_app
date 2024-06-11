import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getCurrentUserToken() async {
  final user = FirebaseAuth.instance.currentUser;
  return user?.uid;
}
