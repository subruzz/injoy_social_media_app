import 'dart:async';
import 'package:flutter/material.dart';

/// A class to debounce function calls, preventing them from being triggered
/// too quickly in succession.
///
/// Use this class to manage the timing of actions, such as user input,
/// by delaying the execution of a function until a specified duration
/// has passed since the last call.
class Debouncer {
  final Duration delay; // Duration to wait before executing the action
  Timer? _timer; // Timer to handle the debouncing

  /// Creates a [Debouncer] with a specified [delay].
  Debouncer({required this.delay});

  /// Runs the given [action] after the specified [delay].
  /// Cancels any previous debounce action.
  void run(VoidCallback action) {
    cancel(); // Cancel any previous debounce action

    _timer = Timer(delay, action);
  }

  /// Cancels the current timer, if any.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Checks if the debounce timer is currently running.
  /// Returns `true` if the timer is active, otherwise `false`.
  bool isRunning() {
    return _timer != null && _timer!.isActive;
  }
}
