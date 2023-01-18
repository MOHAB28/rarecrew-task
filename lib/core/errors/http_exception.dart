class HttpException implements Exception {
  final String message;
  const HttpException({
    required this.message,
  });
  @override
  String toString() {
    return message;
  }
}
