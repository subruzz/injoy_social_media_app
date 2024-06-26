import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/core/errors/auth_errors.dart';
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
}

class AuthremoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String?> getCurrentUserId() async {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<AppUserModel> googleSignIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw const MainException(
        errorMsg: 'Google Sign-In Cancelled',
        details:
            'The user cancelled the Google Sign-In process. Please try again if you wish to sign in with Google.',
      );
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
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential.user == null) {
      throw const MainException(
          errorMsg: 'Unknown error occured',
          details: 'Please try again later!');
    }
    final userDocRef = FirebaseFirestore.instance
        .collection('users')
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
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          userDocRef,
          userModel.toJson(),
        );
      });
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<AppUserModel> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid);

      DocumentSnapshot userSnapshot = await userDocRef.get();
      if (userSnapshot.exists) {
        final data = userSnapshot.data() as Map<String, dynamic>;
        final authUser = AppUserModel.fromJson(data);
        return authUser;
      }
      throw const MainException(
          errorMsg: 'User is not authenticated,please try again later!');
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
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
    final userCred = await getCurrentUserId();
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
