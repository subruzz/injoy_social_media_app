class AppErrorMessages {
  AppErrorMessages._();
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
  // User-Specific Errors
  static const String userNotFound = 'User not found.';
  static const String loginFailed = 'Invalid email or password.';
  static const String signupFailed =
      'Failed to create account. Please try again.';

  // Other Common Errors
  static const String invalidInput = 'Invalid input. Please check your data.';
  static const String permissionDenied =
      'Permission denied. Please grant the required permissions.';

  //for custom error
  static String getErrorMsg(String type) {
    return 'An unexepected error during creating $type, Please try again! ';
  }
}
