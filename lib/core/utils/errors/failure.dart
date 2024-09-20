/// A class representing an error or failure in the application.
class Failure {
  /// A message describing the error.
  final String message;

  /// Additional details about the error.
  final String details;

  /// Creates an instance of [Failure].
  ///
  /// The [message] and [details] parameters can be customized. 
  /// Defaults to 'An unexpected error occurred,' for [message] and 
  /// 'Please try again!' for [details].
  Failure([
    this.message = 'An unexpected error occurred,',
    this.details = 'Please try again!',
  ]);
}
