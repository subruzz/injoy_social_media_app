import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/errors/auth_errors.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/common/models/app_user_model.dart';
import 'package:social_media_app/core/utils/firebase_functions.dart';

abstract interface class AuthRemoteDataSource {
  Future<String?> getCurrentUserId();

  Future<AppUserModel> login(String email, String password);
  Future<AppUserModel> signup(String email, String password);
  Future<AppUserModel> googleSignIn();
  Future<AppUserModel> forgotPassword(String email);
  Future<AppUserModel> verifyPassword(String code, String newPassword);
  Future<AppUserModel?> getCurrentUser();
}

class AuthremoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AppUserModel> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<String?> getCurrentUserId() {
    // TODO: implement getCurrentUserId
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel> googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel> signup(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user == null) {
        throw const MainException(
          errorMsg: 'Sign Up Failed: User Creation Error',
          details:
              'An unexpected occurred while signing you up. Please try again.',
        );
      }
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      AppUserModel userModel = AppUserModel(
        id: user.uid,
        email: email,
        hasPremium: false,
      );
      try {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          transaction.set(
            userDocRef,
            userModel.toJson(),
          );
        });
        return userModel;
      } catch (e) {
        throw MainException(errorMsg: e.toString());
      }
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<AppUserModel> verifyPassword(String code, String newPassword) {
    // TODO: implement verifyPassword
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel?> getCurrentUser() async {
    final userCred = await getCurrentUserToken();
    if (userCred == null) {
      return null;
    }
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userCred);
      DocumentSnapshot userSnapshot = await userDocRef.get();
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
}
