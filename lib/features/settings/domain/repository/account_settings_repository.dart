import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';

abstract interface class AccountSettingsRepo {
  Future<Either<Failure, Unit>> changePassWord(
      {required String email, required String oldP, required String newP});
}
