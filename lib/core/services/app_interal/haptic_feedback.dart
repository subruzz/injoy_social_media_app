import 'package:flutter/services.dart';

/// A singleton helper class for managing haptic feedback in a Flutter application.
class HapticFeedbackHelper {
  // Singleton instance
  static final HapticFeedbackHelper _instance = HapticFeedbackHelper._internal();

  /// Factory constructor to return the singleton instance.
  factory HapticFeedbackHelper() {
    return _instance;
  }

  HapticFeedbackHelper._internal();

  // Basic haptic feedback methods

  /// Triggers a light impact haptic feedback.
  void lightImpact() {
    HapticFeedback.lightImpact();
  }

  /// Triggers a medium impact haptic feedback.
  void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  /// Triggers a heavy impact haptic feedback.
  void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  /// Triggers a selection click haptic feedback.
  void selectionClick() {
    HapticFeedback.selectionClick();
  }

  /// Triggers a generic vibration.
  void vibrate() {
    HapticFeedback.vibrate();
  }

  // Custom feedback methods for granular control

  /// Triggers a custom impact with a specified duration and amplitude.
  void customImpact({required int duration, required int amplitude}) {
    if (duration <= 0 || amplitude <= 0) {
      return; // Ignore invalid parameters
    }
    HapticFeedback.vibrate();
    Future.delayed(Duration(milliseconds: duration), () {
      HapticFeedback.vibrate();
    });
  }

  /// Triggers a series of vibrations based on a given pattern.
  void patternFeedback(List<int> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      Future.delayed(Duration(milliseconds: pattern[i]), () {
        HapticFeedback.vibrate();
      });
    }
  }

  // Predefined feedback patterns

  /// Triggers a double tap feedback.
  void doubleTap() {
    lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      lightImpact();
    });
  }

  /// Triggers a triple tap feedback.
  void tripleTap() {
    lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      lightImpact();
      Future.delayed(const Duration(milliseconds: 100), () {
        lightImpact();
      });
    });
  }

  /// Triggers feedback for a long press.
  void longPress() {
    heavyImpact();
    Future.delayed(const Duration(milliseconds: 300), () {
      heavyImpact();
    });
  }

  /// Triggers a short burst of light impacts.
  void shortBurst() {
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        lightImpact();
      });
    }
  }

  /// Triggers a quick vibration sequence.
  void quickVibrate() {
    vibrate();
    Future.delayed(const Duration(milliseconds: 50), () {
      vibrate();
    });
  }

  // More complex patterns

  /// Triggers vibrations based on a custom pattern.
  void customPattern(List<int> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      Future.delayed(Duration(milliseconds: pattern[i]), () {
        vibrate();
      });
    }
  }

  /// Repeats a vibration pattern a specified number of times.
  void repeatingPattern(List<int> pattern, int repeatCount) {
    for (int j = 0; j < repeatCount; j++) {
      for (int i = 0; i < pattern.length; i++) {
        Future.delayed(Duration(milliseconds: pattern[i] + (j * pattern.fold(0, (a, b) => a + b))), () {
          vibrate();
        });
      }
    }
  }

  // Preset feedback types for common use cases

  /// Triggers feedback for a successful action.
  void successFeedback() {
    selectionClick();
    Future.delayed(const Duration(milliseconds: 50), lightImpact);
  }

  /// Triggers feedback for an error.
  void errorFeedback() {
    heavyImpact();
    Future.delayed(const Duration(milliseconds: 100), mediumImpact);
  }

  /// Triggers feedback for a warning.
  void warningFeedback() {
    mediumImpact();
    Future.delayed(const Duration(milliseconds: 50), lightImpact);
  }

  // Advanced custom feedback methods

  /// Triggers a custom pattern of vibrations with specified durations and amplitudes.
  void customPatternWithAmplitude(List<int> durations, List<int> amplitudes) {
    if (durations.length != amplitudes.length) {
      return; // Mismatched durations and amplitudes
    }

    for (int i = 0; i < durations.length; i++) {
      Future.delayed(Duration(milliseconds: durations[i]), () {
        customImpact(duration: 1, amplitude: amplitudes[i]); // Short burst with specific amplitude
      });
    }
  }

  /// Triggers a crescendo of feedback with increasing intensity.
  void crescendoFeedback() {
    for (int i = 1; i <= 5; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        customImpact(duration: 1, amplitude: i * 50); // Increase amplitude over time
      });
    }
  }
}
