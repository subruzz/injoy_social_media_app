import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/errors/firebase_auth_errors.dart';
import 'package:social_media_app/features/settings/data/datasource/account_settings_data_source.dart';
import 'package:social_media_app/features/settings/domain/repository/account_settings_repository.dart';

class AccountSettingsRepoImpl implements AccountSettingsRepo {
  final AccountSettingsDataSource _accountSettingsDataSource;

  AccountSettingsRepoImpl(
      {required AccountSettingsDataSource accountSettingsDataSource})
      : _accountSettingsDataSource = accountSettingsDataSource;
  @override
  Future<Either<Failure, Unit>> changePassWord(
      {required String email,
      required String oldP,
      required String newP}) async {
    try {
      await _accountSettingsDataSource.changePassWord(
          email: email, oldP: oldP, newP: newP);
      return right(unit);
    } on AuthError catch (e) {
      return left(Failure(e.dialogTitle, e.dialogTitle));
    } on MainException catch (e) {
      return left(Failure(e.details));
    }
  }
}
