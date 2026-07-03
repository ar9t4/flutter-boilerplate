sealed class Result<T> {
  final T? data;

  const Result({this.data});

  bool get hasData => data != null;
}

final class Initial<T> extends Result<T> {
  const Initial();
}

final class Loading<T> extends Result<T> {
  final bool loading;

  const Loading({required this.loading, super.data});
}

final class Success<T> extends Result<T> {
  final T value;

  const Success({required this.value}) : super(data: value);
}

final class Failure<T> extends Result<T> {
  final Error error;

  const Failure({required this.error, super.data});
}

class Error {
  final int? statusCode;
  final String? message;
  final String? code;

  Error(this.statusCode, this.message, this.code);
}
