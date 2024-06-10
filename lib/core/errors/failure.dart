class Failure {
  final String message;
  final String details;
  Failure(
      [this.message = 'An unexpected error occurred,',
      this.details = 'Please try again!']);
}
