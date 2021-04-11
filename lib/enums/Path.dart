enum Path { home, attemptHistory }

extension PathExtension on Path {
  String getPath() {
    switch (this) {
      case Path.home:
        return '/home';
      case Path.attemptHistory:
        return '/attemp_history';
      default:
        throw Exception('Unknown Path type');
    }
  }
}
