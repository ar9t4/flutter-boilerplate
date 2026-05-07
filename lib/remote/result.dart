class Result<T> {
  bool? loading;
  Error? error;
  T? data;

  Result({this.loading, this.error, this.data});
}

class Error {
  final int? statusCode;
  final String? message;
  final String? code;

  Error(this.statusCode, this.message, this.code);
}
