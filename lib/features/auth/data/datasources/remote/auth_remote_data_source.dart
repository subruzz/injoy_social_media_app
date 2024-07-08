import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/firebase_auth_errors.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';

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
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final authUser = AppUserModel.fromJson(data);
        return authUser;
      }
      AppUserModel userModel = AppUserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        hasPremium: false,
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
      //adding user details to firebasedb
      final userDocRef = _firebaseStorage
          .collection(FirebaseCollectionConst.users)
          .doc(user.uid);
      AppUserModel userModel = AppUserModel(
        id: user.uid,
        email: email,
        hasPremium: false,
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
        return authUser;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw MainException(errorMsg: e.toString());
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
  Future<void> signOut(String uid) {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
