import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/firebase_auth_errors.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/shared_preference/chat_wallapaper.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';

import '../../../../../core/const/enums/location_enum.dart';
import '../../../../../core/const/enums/premium_type.dart';
import '../../../../../core/utils/shared_preference/app_language.dart';

abstract interface class AuthRemoteDataSource {
  Future<AppUserModel> login(String email, String password);
  Future<AppUserModel> signup(String email, String password);
  Future<AppUserModel> googleSignIn();
  Future<void> forgotPassword(String email);
  Future<AppUserModel> verifyPassword(String code, String newPassword);
  Future<AppUserModel?> getCurrentUser();
  Future<String?> getCurrentUserId();
  Future<void> deleteUser();
  Future<void> signOut(String uid);
}

class AuthremoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore _firebaseStorage;
  final FirebaseAuth _firebaseAuth;
  AuthremoteDataSourceImpl(
      {required FirebaseFirestore firebaseStorage,
      required FirebaseAuth firebaseAuth})
      : _firebaseStorage = firebaseStorage,
        _firebaseAuth = firebaseAuth;
  @override
  Future<String?> getCurrentUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      //sending password resent mail
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw MainException(
          errorMsg: AppErrorMessages.forgotPasswordFailed,
          details: e.toString());
    }
  }

  @override
  Future<AppUserModel> googleSignIn() async {
    log('came here');
    try {
      if (GoogleSignIn().currentUser != null) {
        log('came here');
      }

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        log('user is null');
        throw const MainException(
            errorMsg: AppErrorMessages.googleSignInCancelled,
            details: AppErrorMessages.googleSigninCancelledDetails);
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      if (userCredential.user == null) {
        throw const MainException();
      }
      final userDocRef = _firebaseStorage
          .collection(FirebaseCollectionConst.users)
          .doc(userCredential.user!.uid);
      DocumentSnapshot userSnapshot = await userDocRef.get();
      final fcm = FirebaseMessaging.instance;
      final token = await fcm.getToken();

      if (userSnapshot.exists) {
        if (token != null) {
          await userDocRef.update({
            'token': token,
          });
        }
        final data = userSnapshot.data() as Map<String, dynamic>;
        final authUser = AppUserModel.fromJson(data);
        return authUser;
      }

      AppUserModel userModel = AppUserModel(
        savedPosts: const [],
        showLastSeen: true,
        notificationPreferences: NotificationPreferences(),
        visitedUserCount: 0,
        id: userCredential.user!.uid,
        onlineStatus: false,
        email: userCredential.user!.email ?? '',
        hasPremium: false,
        followersCount: 0,
        token: token ?? '',
        followingCount: 0,
      );

      await _firebaseStorage.runTransaction((transaction) async {
        transaction.set(
          userDocRef,
          userModel.toJson(),
        );
      });
      return userModel;
    } on MainException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw AuthError.from(e);
    } catch (e) {
      log(e.toString());
      throw const MainException(errorMsg: AppErrorMessages.googleSignInFailed);
    }
  }

  @override
  Future<AppUserModel> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
//getting user ref
      final userDocRef = _firebaseStorage
          .collection(FirebaseCollectionConst.users)
          .doc(credential.user!.uid);
      // Login:
      if (!kIsWeb) {
        final fcm = FirebaseMessaging.instance;
        final token = await fcm.getToken();
        if (token != null) {
          await userDocRef.update({
            'token': token,
          });
        }
      }
      DocumentSnapshot userSnapshot = await userDocRef.get();
      //checking if user  exist
      //if so return  the user details
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final authUser = AppUserModel.fromJson(data);
        return authUser;
      }

      // This should not normally happen as authenticated users are expected to have user data
      throw const MainException(errorMsg: AppErrorMessages.loginFailed);
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw MainException(
          errorMsg: AppErrorMessages.loginFailed, details: e.toString());
    }
  }

  @override
  Future<AppUserModel> signup(String email, String password) async {
    User? user;

    try {
      // Create user with email and password
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;

      if (user == null) {
        throw const MainException(
          errorMsg: AppErrorMessages.signUpFailed,
        );
      }
      String? token = '';
      if (isThatMobile) {
        final fcm = FirebaseMessaging.instance;
        token = await fcm.getToken();
      }

      //adding user details to firebasedb
      final userDocRef = _firebaseStorage
          .collection(FirebaseCollectionConst.users)
          .doc(user.uid);
      AppUserModel userModel = AppUserModel(
        showLastSeen: true,
        savedPosts: const [],
        notificationPreferences: NotificationPreferences(),
        visitedUserCount: 0,
        id: user.uid,
        onlineStatus: false,
        email: email,
        hasPremium: false,
        followersCount: 0,
        followingCount: 0,
        token: token ?? '',
      );
      await _firebaseStorage.runTransaction((transaction) async {
        transaction.set(userDocRef, userModel.toJson());
      });

      return userModel;
    } on FirebaseAuthException catch (e) {
      log('error from here', error: e);
      throw AuthError.from(e);
    } catch (e) {
      //delete the user only if it was created but not added in the firebase
      if (user != null) {
        await user.delete();
      }

      throw MainException(
          errorMsg: AppErrorMessages.signUpFailed, details: e.toString());
    }
  }

  @override
  Future<AppUserModel> verifyPassword(String code, String newPassword) {
    // TODO: implement verifyPassword
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel?> getCurrentUser() async {
    final userCred = await getCurrentUserId();
    if (userCred == null) {
      return null;
    }
    try {
      //getting user details from the uid
      final userDocRef = _firebaseStorage
          .collection(FirebaseCollectionConst.users)
          .doc(userCred);
      DocumentSnapshot userSnapshot = await userDocRef.get();
      //if user exist return the usermodel
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final authUser = AppUserModel.fromJson(data);
        return _checkAndUpdateSubscription(authUser);
      } else {
        throw Exception();
      }
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  Future<AppUserModel> _checkAndUpdateSubscription(AppUserModel user) async {
    try {
      if (user.userPrem == null) return user;
      final purchasedAt = (user.userPrem?.purchasedAt as Timestamp).toDate();
      final premiumSubType = user.userPrem?.premType ?? PremiumSubType.oneMonth;

      final subscriptionEndDate =
          _calculateSubscriptionEndDate(purchasedAt, premiumSubType);

      if (DateTime.now().isAfter(subscriptionEndDate)) {
        // Subscription has expired
        final userRef = _firebaseStorage
            .collection(FirebaseCollectionConst.users)
            .doc(user.id);

        await userRef.update({
          'hasPremium': false,
          'userPremium': FieldValue.delete(),
        });
        // Re-fetch the updated user data
        final updatedUserSnapshot = await userRef.get();
        final updatedData = updatedUserSnapshot.data() as Map<String, dynamic>;
        return AppUserModel.fromJson(updatedData);
      }
      return user;
    } catch (e) {
      log('erro eudf ${e.toString()}');
      throw const MainException();
    }
  }

  DateTime _calculateSubscriptionEndDate(
      DateTime purchasedAt, PremiumSubType subType) {
    switch (subType) {
      case PremiumSubType.oneMonth:
        return purchasedAt.add(const Duration(days: 30));
      case PremiumSubType.threeMonth:
        return purchasedAt.add(const Duration(days: 90));
      case PremiumSubType.oneYear:
        return purchasedAt.add(const Duration(days: 365));
      default:
        return purchasedAt;
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _firebaseAuth.currentUser?.delete();
    } catch (e) {
      log('error : ${e.toString()}');
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<void> signOut(String uid) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        bool isGoogleSignIn = user.providerData
            .any((userInfo) => userInfo.providerId == 'google.com');
        await FirebaseAuth.instance.signOut();
        if (isGoogleSignIn) {
          await GoogleSignIn().disconnect();
        }
        _firebaseStorage.collection('users').doc(uid).update({'token': ''});

        await AppLanguageSP.clearLocale();
        await ChatWallapaperSp.clearChatWallapaper();
      }
    } catch (e) {
      throw const MainException();
    }
  }
}
