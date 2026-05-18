sealed class Result<S, E> {
  const Result();
}

class Success<S, E> extends Result<S, E> {
  final S data;
  const Success(this.data);
}

class Failure<S, E> extends Result<S, E> {
  final E error;
  const Failure(this.error);
}
