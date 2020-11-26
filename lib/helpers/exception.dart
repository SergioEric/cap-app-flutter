class CleanException implements Exception {
  final dynamic message;

  CleanException(this.message)
      : assert(message != null || message.toString().isNotEmpty);

  @override
  String toString() {
    return this.message;
  }
}
