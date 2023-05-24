import 'dart:async';

/// Creates a custom delay to execute some behavior after some seconds

class DelayedActionService {
  static Timer _timer = Timer(const Duration(seconds: 50), () {});

  /// [delay] Need to be in seconds
  static Future<void> execute(Function() function, {int delay = 50}) async {
    if (_timer.isActive) {
      _timer.cancel();
    }

    _timer = Timer(Duration(seconds: delay), () {
      function.call();
    });
  }
}
