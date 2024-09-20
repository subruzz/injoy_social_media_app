import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';

import '../../../../core/utils/errors/firebase_auth_errors.dart';

abstract interface class AccountSettingsDataSource {
  Future<void> changePassWord(
      {required String email, required String oldP, required String newP});
}

class AccountSettingsDataSourceImpl implements AccountSettingsDataSource {
  @override
  Future<void> changePassWord(
      {required String email,
      required String oldP,
      required String newP}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw const MainException();
      }
      var cred = EmailAuthProvider.credential(email: email, password: oldP);

      await currentUser.reauthenticateWithCredential(cred).then((value) {
        currentUser.updatePassword(newP);
      });
    } on FirebaseAuthException catch (e) {
      throw AuthError.from(e);
    } catch (e) {
      throw const MainException();
    }
  }
}
