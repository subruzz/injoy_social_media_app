import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/call/data/model/call_model.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';

abstract interface class CallRemoteDatasource {
  Future<void> makeCall(CallEntity call);
  Future<void> endCall(String callerId, String recieverId);
  Future<void> updateCallHistoryStatus(CallEntity call);

  Future<void> saveCallHistory(CallEntity call);
  Stream<List<CallEntity>> getUserCalling(String uid);
  Stream<List<CallEntity>> getMyCallHistory(String uid);
  Future<String> getCallChannelId(String uid);
}

class CallRemoteDatasourceImpl implements CallRemoteDatasource {
  final FirebaseFirestore _firebaseFirestore;

  CallRemoteDatasourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> makeCall(CallEntity call) async {
    final callCollection =
        _firebaseFirestore.collection(FirebaseCollectionConst.calls);
    String callId = callCollection.doc().id;

    final callerData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: callId,
      isCallDialed: true,
      isMissed: false,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    final receiverData = CallModel(
      callerId: call.receiverId,
      callerName: call.receiverName,
      callerProfileUrl: call.receiverProfileUrl,
      callId: callId,
      isCallDialed: false,
      isMissed: false,
      receiverId: call.callerId,
      receiverName: call.callerName,
      receiverProfileUrl: call.callerProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    try {
      await callCollection.doc(call.callerId).set(callerData);
      await callCollection.doc(call.receiverId).set(receiverData);
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> endCall(String callerId, String recieverId) async {
    final callCollection =
        _firebaseFirestore.collection(FirebaseCollectionConst.calls);

    try {
      await callCollection.doc(callerId).delete();
      await callCollection.doc(recieverId).delete();
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<String> getCallChannelId(String uid) async {
    final callCollection =
        _firebaseFirestore.collection(FirebaseCollectionConst.calls);

    return callCollection.doc(uid).get().then((callConnection) {
      if (callConnection.exists) {
        return callConnection.data()!['callId'];
      }
      return Future.value("");
    });
  }

  @override
  Stream<List<CallEntity>> getUserCalling(String uid) {
    final callCollection =
        _firebaseFirestore.collection(FirebaseCollectionConst.calls);
    try {
      return callCollection
          .where("callerId", isEqualTo: uid)
          .limit(1)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((e) => CallModel.fromSnapshot(e))
              .toList());
    } on SocketException catch (e) {
      throw const MainException();
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> saveCallHistory(CallEntity call) async {
    final myHistoryCollection = _firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(call.callerId)
        .collection(FirebaseCollectionConst.callHistory);
    final otherHistoryCollection = _firebaseFirestore
        .collection(FirebaseCollectionConst.users)
        .doc(call.receiverId)
        .collection(FirebaseCollectionConst.callHistory);

    final callData = CallModel(
      callerId: call.callerId,
      callerName: call.callerName,
      callerProfileUrl: call.callerProfileUrl,
      callId: call.callId,
      isCallDialed: call.isCallDialed,
      isMissed: call.isMissed,
      receiverId: call.receiverId,
      receiverName: call.receiverName,
      receiverProfileUrl: call.receiverProfileUrl,
      createdAt: Timestamp.now(),
    ).toDocument();

    try {
      await myHistoryCollection
          .doc(call.callId)
          .set(callData, SetOptions(merge: true));
      await otherHistoryCollection
          .doc(call.callId)
          .set(callData, SetOptions(merge: true));
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> updateCallHistoryStatus(CallEntity call) async {
    // TODO: implement updateCallHistoryStatus
    throw UnimplementedError();
  }

  @override
  Stream<List<CallEntity>> getMyCallHistory(String uid) {
    throw UnimplementedError();
  }
}
