import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';

class CallModel extends CallEntity {
  const CallModel(
      {required super.callId,
      required super.callerId,
      required super.callerName,
      required super.callerProfileUrl,
      required super.receiverId,
      required super.receiverName,
      required super.receiverProfileUrl,
      required super.isCallDialed,
      required super.isMissed,
      required super.createdAt});

  factory CallModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return CallModel(
      receiverProfileUrl: snap['receiverProfileUrl'],
      receiverName: snap['receiverName'],
      receiverId: snap['receiverId'],
      isCallDialed: snap['isCallDialed'],
      callId: snap['callId'],
      callerProfileUrl: snap['callerProfileUrl'],
      callerName: snap['callerName'],
      callerId: snap['callerId'],
      isMissed: snap['isMissed'],
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toDocument() => {
        "receiverProfileUrl": receiverProfileUrl,
        "receiverName": receiverName,
        "receiverId": receiverId,
        "isCallDialed": isCallDialed,
        "callId": callId,
        "callerProfileUrl": callerProfileUrl,
        "callerName": callerName,
        "callerId": callerId,
        "isMissed": isMissed,
        "createdAt": createdAt,
      };
}
