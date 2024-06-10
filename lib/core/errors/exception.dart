class MainException implements Exception {
  final String errorMsg;
  final String details;
  const MainException(
      {this.errorMsg = 'Oops!',
      this.details = 'Something went wrong. Please try again later.'});
}
