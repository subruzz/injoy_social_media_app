/// A custom exception class for handling application-specific errors.
class MainException implements Exception {
  /// The error message to be displayed.
  final String errorMsg;

  /// Additional details about the error.
  final String details;

  /// Creates an instance of [MainException].
  ///
  /// The [errorMsg] and [details] parameters can be customized. 
  /// Defaults to 'Oops!' for [errorMsg] and 
  /// 'Something went wrong. Please try again later.' for [details].
  const MainException({
    this.errorMsg = 'Oops!',
    this.details = 'Something went wrong. Please try again later.',
  });
}
