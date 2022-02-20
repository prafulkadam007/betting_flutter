class CommonException implements Exception {
  final String msg;
  CommonException(this.msg);
  String toString() => msg;
}
