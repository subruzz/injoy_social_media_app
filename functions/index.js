const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.followUser = functions.https.onCall(async (data, context) => {
    const { currentUserId, targetUserId } = data;

    const currentUserRef = admin.firestore().collection('users').doc(currentUserId);
    const targetUserRef = admin.firestore().collection('users').doc(targetUserId);

    const currentUserDoc = await currentUserRef.get();
    const targetUserDoc = await targetUserRef.get();

    if (!currentUserDoc.exists || !targetUserDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'User not found');
    }

    const currentUserData = currentUserDoc.data();
    const targetUserData = targetUserDoc.data();

    if (currentUserData.following.includes(targetUserId)) {
        throw new functions.https.HttpsError('already-exists', 'Already following the user');
    }

    await currentUserRef.update({
        following: admin.firestore.FieldValue.arrayUnion(targetUserId),
        followingCount: admin.firestore.FieldValue.increment(1)
    });

    await targetUserRef.update({
        followers: admin.firestore.FieldValue.arrayUnion(currentUserId),
        followerCount: admin.firestore.FieldValue.increment(1)
    });

    return { success: true };
});
