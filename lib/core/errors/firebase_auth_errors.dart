import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
  'email-already-exists': AuthErrorEmailAlreadyExists(),
  'invalid-verification-code': AuthErrorInvalidVerificationCode(),
  'invalid-verification-id': AuthErrorInvalidVerificationId(),
  'quota-exceeded': AuthErrorQuotaExceeded(),
  'provider-already-linked': AuthErrorProviderAlreadyLinked(),
  'credential-already-in-use': AuthErrorCredentialAlreadyInUse(),
  'user-mismatch': AuthErrorUserMismatch(),
  'account-exists-with-different-credential':
      AuthErrorAccountExistsWithDifferentCredential(),
  'expired-action-code': AuthErrorExpiredActionCode(),
  'invalid-action-code': AuthErrorInvalidActionCode(),
  'missing-action-code': AuthErrorMissingActionCode(),
  'user-token-expired': AuthErrorUserTokenExpired(),
  'invalid-credential': AuthErrorInvalidCredential(),
  'user-token-revoked': AuthErrorUserTokenRevoked(),
  'invalid-message-payload': AuthErrorInvalidMessagePayload(),
  'invalid-sender': AuthErrorInvalidSender(),
  'invalid-recipient-email': AuthErrorInvalidRecipientEmail(),
  'missing-iframe-start': AuthErrorMissingIframeStart(),
  'missing-iframe-end': AuthErrorMissingIframeEnd(),
  'missing-iframe-src': AuthErrorMissingIframeSrc(),
  'auth-domain-config-required': AuthErrorAuthDomainConfigRequired(),
  'missing-app-credential': AuthErrorMissingAppCredential(),
  'invalid-app-credential': AuthErrorInvalidAppCredential(),
  'session-cookie-expired': AuthErrorSessionCookieExpired(),
  'uid-already-exists': AuthErrorUidAlreadyExists(),
  'invalid-cordova-configuration': AuthErrorInvalidCordovaConfiguration(),
  'app-deleted': AuthErrorAppDeleted(),
  'user-token-mismatch': AuthErrorUserTokenMismatch(),
  'web-storage-unsupported': AuthErrorWebStorageUnsupported(),
  'app-not-authorized': AuthErrorAppNotAuthorized(),
  'keychain-error': AuthErrorKeychainError(),
  'internal-error': AuthErrorInternalError(),
  'invalid-login-credentials': AuthErrorInvalidLoginCredentials(),
};

abstract class AuthError implements Exception {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(FirebaseAuthException exception) =>
      authErrorMapping[exception.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
          dialogTitle: 'Authentication error',
          dialogText:
              'An unexpected authentication error occurred. Please try again.',
        );
}
// auth/user-not-found

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          dialogTitle: 'User not found',
          dialogText: 'The given user was not found on the server!',
        );
}

// auth/weak-password

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          dialogTitle: 'Weak password',
          dialogText:
              'Please choose a stronger password consisting of more characters!',
        );
}

// auth/invalid-email

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          dialogTitle: 'Invalid email',
          dialogText: 'Please double check your email and try again!',
        );
}

// auth/operation-not-allowed

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          dialogTitle: 'Operation not allowed',
          dialogText: 'You cannot register using this method at this moment!',
        );
}

// auth/email-already-in-use

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          dialogTitle: 'Email already in use',
          dialogText: 'Please choose another email to register with!',
        );
}

// auth/requires-recent-login

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          dialogTitle: 'Requires recent login',
          dialogText:
              'You need to log out and log back in again in order to perform this operation',
        );
}

// auth/no-current-user

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogTitle: 'No current user!',
          dialogText: 'No current user with this information was found!',
        );
}

// Extend with more specific error classes

@immutable
class AuthErrorEmailAlreadyExists extends AuthError {
  const AuthErrorEmailAlreadyExists()
      : super(
          dialogTitle: 'Email already exists',
          dialogText:
              'The email address already exists. Please use a different email.',
        );
}

@immutable
class AuthErrorInvalidVerificationCode extends AuthError {
  const AuthErrorInvalidVerificationCode()
      : super(
          dialogTitle: 'Invalid verification code',
          dialogText: 'Invalid verification code. Please enter a valid code.',
        );
}

// Add similar classes for other error types as required

@immutable
class AuthErrorInvalidVerificationId extends AuthError {
  const AuthErrorInvalidVerificationId()
      : super(
          dialogTitle: 'Invalid verification ID',
          dialogText:
              'Invalid verification ID. Please request a new verification code.',
        );
}

@immutable
class AuthErrorQuotaExceeded extends AuthError {
  const AuthErrorQuotaExceeded()
      : super(
          dialogTitle: 'Quota exceeded',
          dialogText: 'Quota exceeded. Please try again later.',
        );
}

// Continue with all other errors similarly

@immutable
class AuthErrorProviderAlreadyLinked extends AuthError {
  const AuthErrorProviderAlreadyLinked()
      : super(
          dialogTitle: 'Provider already linked',
          dialogText: 'The account is already linked with another provider.',
        );
}

@immutable
class AuthErrorCredentialAlreadyInUse extends AuthError {
  const AuthErrorCredentialAlreadyInUse()
      : super(
          dialogTitle: 'Credential already in use',
          dialogText:
              'This credential is already associated with a different user account.',
        );
}

@immutable
class AuthErrorUserMismatch extends AuthError {
  const AuthErrorUserMismatch()
      : super(
          dialogTitle: 'User mismatch',
          dialogText:
              'The supplied credentials do not correspond to the previously signed in user.',
        );
}

@immutable
class AuthErrorAccountExistsWithDifferentCredential extends AuthError {
  const AuthErrorAccountExistsWithDifferentCredential()
      : super(
          dialogTitle: 'Account exists with different credential',
          dialogText:
              'An account already exists with the same email but different sign-in credentials.',
        );
}

@immutable
class AuthErrorExpiredActionCode extends AuthError {
  const AuthErrorExpiredActionCode()
      : super(
          dialogTitle: 'Expired action code',
          dialogText:
              'The action code has expired. Please request a new action code.',
        );
}

@immutable
class AuthErrorInvalidActionCode extends AuthError {
  const AuthErrorInvalidActionCode()
      : super(
          dialogTitle: 'Invalid action code',
          dialogText:
              'The action code is invalid. Please check the code and try again.',
        );
}

@immutable
class AuthErrorMissingActionCode extends AuthError {
  const AuthErrorMissingActionCode()
      : super(
          dialogTitle: 'Missing action code',
          dialogText:
              'The action code is missing. Please provide a valid action code.',
        );
}

@immutable
class AuthErrorUserTokenExpired extends AuthError {
  const AuthErrorUserTokenExpired()
      : super(
          dialogTitle: 'User token expired',
          dialogText:
              'The user\'s token has expired, and authentication is required. Please sign in again.',
        );
}

@immutable
class AuthErrorInvalidCredential extends AuthError {
  const AuthErrorInvalidCredential()
      : super(
          dialogTitle: 'Invalid credential',
          dialogText: 'The supplied credential is malformed or has expired.',
        );
}

@immutable
class AuthErrorUserTokenRevoked extends AuthError {
  const AuthErrorUserTokenRevoked()
      : super(
          dialogTitle: 'User token revoked',
          dialogText:
              'The user\'s token has been revoked. Please sign in again.',
        );
}

@immutable
class AuthErrorInvalidMessagePayload extends AuthError {
  const AuthErrorInvalidMessagePayload()
      : super(
          dialogTitle: 'Invalid message payload',
          dialogText:
              'The email template verification message payload is invalid.',
        );
}

@immutable
class AuthErrorInvalidSender extends AuthError {
  const AuthErrorInvalidSender()
      : super(
          dialogTitle: 'Invalid sender',
          dialogText:
              'The email template sender is invalid. Please verify the sender\'s email.',
        );
}

@immutable
class AuthErrorInvalidRecipientEmail extends AuthError {
  const AuthErrorInvalidRecipientEmail()
      : super(
          dialogTitle: 'Invalid recipient email',
          dialogText:
              'The recipient email address is invalid. Please provide a valid recipient email.',
        );
}

@immutable
class AuthErrorMissingIframeStart extends AuthError {
  const AuthErrorMissingIframeStart()
      : super(
          dialogTitle: 'Missing iframe start',
          dialogText: 'The email template is missing the iframe start tag.',
        );
}

@immutable
class AuthErrorMissingIframeEnd extends AuthError {
  const AuthErrorMissingIframeEnd()
      : super(
          dialogTitle: 'Missing iframe end',
          dialogText: 'The email template is missing the iframe end tag.',
        );
}

@immutable
class AuthErrorMissingIframeSrc extends AuthError {
  const AuthErrorMissingIframeSrc()
      : super(
          dialogTitle: 'Missing iframe src',
          dialogText: 'The email template is missing the iframe src attribute.',
        );
}

@immutable
class AuthErrorAuthDomainConfigRequired extends AuthError {
  const AuthErrorAuthDomainConfigRequired()
      : super(
          dialogTitle: 'Auth domain config required',
          dialogText:
              'The authDomain configuration is required for the action code verification link.',
        );
}

@immutable
class AuthErrorMissingAppCredential extends AuthError {
  const AuthErrorMissingAppCredential()
      : super(
          dialogTitle: 'Missing app credential',
          dialogText:
              'The app credential is missing. Please provide valid app credentials.',
        );
}

@immutable
class AuthErrorInvalidAppCredential extends AuthError {
  const AuthErrorInvalidAppCredential()
      : super(
          dialogTitle: 'Invalid app credential',
          dialogText:
              'The app credential is invalid. Please provide a valid app credential.',
        );
}

@immutable
class AuthErrorSessionCookieExpired extends AuthError {
  const AuthErrorSessionCookieExpired()
      : super(
          dialogTitle: 'Session cookie expired',
          dialogText:
              'The Firebase session cookie has expired. Please sign in again.',
        );
}

@immutable
class AuthErrorUidAlreadyExists extends AuthError {
  const AuthErrorUidAlreadyExists()
      : super(
          dialogTitle: 'UID already exists',
          dialogText: 'The provided user ID is already in use by another user.',
        );
}

@immutable
class AuthErrorInvalidCordovaConfiguration extends AuthError {
  const AuthErrorInvalidCordovaConfiguration()
      : super(
          dialogTitle: 'Invalid Cordova configuration',
          dialogText: 'The provided Cordova configuration is invalid.',
        );
}

@immutable
class AuthErrorAppDeleted extends AuthError {
  const AuthErrorAppDeleted()
      : super(
          dialogTitle: 'App deleted',
          dialogText: 'This instance of FirebaseApp has been deleted.',
        );
}

@immutable
class AuthErrorUserTokenMismatch extends AuthError {
  const AuthErrorUserTokenMismatch()
      : super(
          dialogTitle: 'User token mismatch',
          dialogText:
              'The provided user\'s token has a mismatch with the authenticated user\'s user ID.',
        );
}

@immutable
class AuthErrorWebStorageUnsupported extends AuthError {
  const AuthErrorWebStorageUnsupported()
      : super(
          dialogTitle: 'Web storage unsupported',
          dialogText: 'Web storage is not supported or is disabled.',
        );
}

@immutable
class AuthErrorAppNotAuthorized extends AuthError {
  const AuthErrorAppNotAuthorized()
      : super(
          dialogTitle: 'App not authorized',
          dialogText:
              'The app is not authorized to use Firebase Authentication with the provided API key.',
        );
}

@immutable
class AuthErrorKeychainError extends AuthError {
  const AuthErrorKeychainError()
      : super(
          dialogTitle: 'Keychain error',
          dialogText:
              'A keychain error occurred. Please check the keychain and try again.',
        );
}

@immutable
class AuthErrorInternalError extends AuthError {
  const AuthErrorInternalError()
      : super(
          dialogTitle: 'Internal error',
          dialogText:
              'An internal authentication error occurred. Please try again later.',
        );
}

@immutable
class AuthErrorInvalidLoginCredentials extends AuthError {
  const AuthErrorInvalidLoginCredentials()
      : super(
          dialogTitle: 'Invalid login credentials',
          dialogText: 'Invalid login credentials. Please check and try again.',
        );
}
// auth/user-disabled

@immutable
class AuthErrorUserDisabled extends AuthError {
  const AuthErrorUserDisabled()
      : super(
          dialogTitle: 'User Disabled',
          dialogText:
              'This user account has been disabled. Please contact support for assistance.',
        );
}

// auth/invalid-verification-code
