import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';

abstract interface class SettingsDatasource {
  Future<void> updateNotificationField(
      {required String myId,
      required NotificationPreferences notificationPreference});
}

class SettingsDatasourceImpl implements SettingsDatasource {
  final FirebaseFirestore _firebaseFirestore;

  SettingsDatasourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> updateNotificationField(
      {required String myId,
      required NotificationPreferences notificationPreference}) async {
    final userRef =
        _firebaseFirestore.collection(FirebaseCollectionConst.users);

    try {
   
      await userRef
          .doc(myId)
          .update({'notificationPreferences': notificationPreference.toMap()});
    } catch (e) {
      throw const MainException();
    }
  }
}
