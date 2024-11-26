class TaskException implements Exception {
  final String message;
  final int statusCode;

  TaskException(this.message, this.statusCode);
}
