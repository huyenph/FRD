enum TokenType {
  tokenExpired,
  anotherDevice,
}

abstract class TokenExpiredListener {
  void onTokenExpired(TokenType type);
}

class TokenExpiredHandler {
  final Set<TokenExpiredListener> _listener = <TokenExpiredListener>{};

  void register(TokenExpiredListener listener) {
    _listener.add(listener);
  }

  void unRegister(TokenExpiredListener listener) {
    _listener.remove(listener);
  }

  void call(TokenType type) {
    if (_listener.isNotEmpty) {
      TokenExpiredListener listener = _listener.last;
      _listener.clear();
      listener.onTokenExpired(type);
    }
  }
}
