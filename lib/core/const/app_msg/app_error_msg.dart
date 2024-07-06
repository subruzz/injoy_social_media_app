class AppErrorMessages {
  AppErrorMessages._();
  //google sign in error
  static const String googleSignInFailed =
      'Google sign-in failed. Please try again.';
  static const String googleSigninCancelledDetails =
      'The user cancelled the Google Sign-In process. Please try again if you wish to sign in with Google.';
  static const String googleSignInCancelled =
      'Google sign-in  cancelled. Please try again.';
  static const String googleSignInAccountNotFound =
      'Google account not found. Please check your account and try again.';
  static const String googleSignInInvalidCredentials =
      'Invalid Google credentials. Please try again.';
  //login error
  static const String loginFailed =
      'Login failed. Please check your credentials and try again.';
  static const String loginUserDisabled =
      'This user account has been disabled. Please contact support.';
  static const String loginUserNotFound =
      'No account found with this email. Please check your email and try again.';
  static const String loginInvalidEmail =
      'Invalid email format. Please check your email and try again.';
  static const String loginWrongPassword =
      'Incorrect password. Please try again or reset your password.';
//signup error
  static const String signUpFailed =
      'Sign-up failed. Please check your information and try again.';
  static const String signUpEmailAlreadyInUse =
      'This email is already in use. Please use a different email or log in.';
  static const String signUpWeakPassword =
      'Weak password. Please choose a stronger password with more characters.';
  static const String signUpInvalidEmail =
      'Invalid email format. Please check your email and try again.';
//forgot password error
  static const String forgotPasswordFailed =
      'Failed to send password reset email. Please try again.';
  static const String forgotPasswordInvalidEmail =
      'Invalid email format. Please check your email and try again.';
  static const String forgotPasswordUserNotFound =
      'No account found with this email. Please check your email and try again.';
  static const String forgotPasswordQuotaExceeded =
      'Too many password reset requests. Please try again later.';

  // General Error Messages
  static const String somethingWentWrong =
      'Something went wrong. Please try again later.';
  static const String networkError =
      'No internet connection. Please check your network settings.';
  static const String serverError = 'Server error. Please try again later.';
  static const String unauthorized =
      'You are not authorized to perform this action.';

  // Status-Specific Errors
  static const String statusEmptyContent =
      'Your status seems a bit empty. Add a photo or some text to share!';
  static const String statusCreationFailed =
      'Sorry, there was a hiccup. Give it another try, and your status will be up in no time!';
  static const String statusUpdateFailed =
      'Failed to update status. Please try again.';
  static const String statusDeleteFailed =
      'Failed to delete status. Please try again.';
  static const String statusNotFound = 'Status not found.';
  static const String statusFetchFailed =
      'There was a problem loading the statuses';

  static const String myStatusFetchFailed =
      'We couldn\'t load your statuses. Please try again later.';
  // Post-Specific Errors
  static const String postCreationFailed =
      'Failed to create post. Please try again.';
  static const String postUpdateFailed =
      'Failed to update post. Please try again.';
  static const String postDeleteFailed =
      'Failed to delete post. Please try again.';
  static const String postNotFound = 'Post not found.';
  static const String postNoContent =
      'Your post is feeling a little lonely. Add a caption or a photos to keep it company!';
//profile errors
  static const String profileCreateFailure = 'Error while creating profile please try again!';

  // Other Common Errors
  static const String invalidInput = 'Invalid input. Please check your data.';
  static const String permissionDenied =
      'Permission denied. Please grant the required permissions.';

  //for custom error
  static String getErrorMsg(String type) {
    return 'An unexepected error during creating $type, Please try again! ';
  }
}
