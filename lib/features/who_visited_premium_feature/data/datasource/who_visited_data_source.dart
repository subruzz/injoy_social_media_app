import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';

abstract interface class WhoVisitedDataSource {
  Future<void> addTheVisitedUser(
      {required String visitedUserId, required String myId});
  Future<List<UserVisit>> getProfileVisitedProfiles({required String myId});
}

class WhoVisitedDataSourceImpl implements WhoVisitedDataSource {
  final FirebaseFirestore _firebaseFirestore;

  WhoVisitedDataSourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
Future<void> addTheVisitedUser({
  required String visitedUserId,
  required String myId,
}) async {
  final userRef = _firebaseFirestore.collection(FirebaseCollectionConst.users);
  final whoVisitedMeRef =
      _firebaseFirestore.collection(FirebaseCollectionConst.whoVisitedMe);
  try {
    await _firebaseFirestore.runTransaction((transaction) async {
      // Reference to the visited user's document
      final visitedUserDocRef = userRef.doc(visitedUserId);
      final visitedUserDoc = await transaction.get(visitedUserDocRef);

      if (!visitedUserDoc.exists) {
        return;
      }

      // Reference to the 'whoVisitedMe' collection for the visited user
      final whoVisitedMeDocRef = whoVisitedMeRef
          .doc(visitedUserId)
          .collection(FirebaseCollectionConst.visitors)
          .doc(myId);

      // Check if the visitor record already exists
      final whoVisitedMeDoc = await transaction.get(whoVisitedMeDocRef);

      if (!whoVisitedMeDoc.exists) {
        // Update the visit count in the visited user's document
        transaction.update(visitedUserDocRef, {'visitCount': FieldValue.increment(1)});

        // Add the visitor record to the 'whoVisitedMe' collection
        transaction.set(whoVisitedMeDocRef, {
          'visitorUserId': myId,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    });
  } catch (e) {
    throw const MainException();
  }
}


  @override
  Future<List<UserVisit>> getProfileVisitedProfiles(
      {required String myId}) async {
    try {
      // Reference to the 'whoVisitedMe' collection
      final whoVisitedMeRef = _firebaseFirestore
          .collection(FirebaseCollectionConst.whoVisitedMe)
          .doc(myId)
          .collection(FirebaseCollectionConst.visitors);

      // Fetch the list of visited user IDs and their timestamps, sorted by timestamp
      final visitedUsersSnapshot = await whoVisitedMeRef
          .orderBy('timestamp', descending: true)
          .get();

      if (visitedUsersSnapshot.docs.isEmpty) {
        return []; // No visitors
      }

      // Extract the user IDs and timestamps from the documents
      final visitedUserIdsWithTimestamps = visitedUsersSnapshot.docs.map((doc) {
        final data = doc.data();
        final userId = doc.id;
        final timestamp = (data['timestamp'] as Timestamp).toDate();

        return {
          'userId': userId,
          'timestamp': timestamp,
        };
      }).toList();

      // Extract user IDs
      final visitedUserIds = visitedUserIdsWithTimestamps
          .map((entry) => entry['userId'] as String)
          .toList();

      // Reference to the 'users' collection
      final usersRef =
          _firebaseFirestore.collection(FirebaseCollectionConst.users);

      // Fetch details of visited users using 'whereIn' query
      final userDetailsSnapshot = await usersRef
          .where(FieldPath.documentId, whereIn: visitedUserIds)
          .get();

      // Create a map of user ID to user details
      final userMap = <String, PartialUser>{};
      for (var doc in userDetailsSnapshot.docs) {
        if (doc.exists) {
          final data = doc.data();
          final user = PartialUser.fromJson(data);
          userMap[user.id] = user;
        }
      }

      // Combine user details with their visit timestamps
      final visitedUsers = visitedUserIdsWithTimestamps
          .map((entry) {
            final userId = entry['userId'] as String;
            final timestamp = entry['timestamp'] as DateTime;

            final user = userMap[userId];
            if (user != null) {
              return UserVisit(user: user, timestamp: timestamp);
            } else {
              return null; 
            }
          })
          .whereType<UserVisit>()
          .toList();

      return visitedUsers;
    } catch (e) {
      throw const MainException();
    }
  }
}
