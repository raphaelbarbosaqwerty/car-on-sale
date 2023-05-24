import 'dart:async';

/// Creates a custom delay to execute some behavior after some seconds

class DelayedAction {
  static Timer _timer = Timer(const Duration(seconds: 0), () {});

  /// [delay] Need to be in seconds, will execute in periods of 1 second
  static Future<void> periodic(void Function(Timer) callback,
      {Duration duration = const Duration(seconds: 1)}) async {
    _timer = Timer.periodic(
      duration,
      (Timer timer) {
        callback.call(timer);
      },
    );
  }

  static Future<void> forceCancel() async {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }
}
