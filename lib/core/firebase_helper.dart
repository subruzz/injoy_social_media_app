import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore;

  FirebaseHelper({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Method to get user details as a stream
  Stream<AppUserModel> getUserDetailsStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return AppUserModel.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    });
  }

  // Method to get user details as a future
  Future<AppUserModel> getUserDetailsFuture(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return AppUserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      throw Exception("User not found");
    }
  }
}
