class TimeOutException implements Exception {
  final String message;

  const TimeOutException(this.message);
}

class ServerException implements Exception {
  final String message;

  const ServerException(this.message);
}
