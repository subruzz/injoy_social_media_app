import 'package:flutter/services.dart';

class HapticFeedbackHelper {
  // Singleton pattern
  static final HapticFeedbackHelper _instance = HapticFeedbackHelper._internal();

  factory HapticFeedbackHelper() {
    return _instance;
  }

  HapticFeedbackHelper._internal();

  // Methods for different types of haptic feedback
  void lightImpact() {
    HapticFeedback.lightImpact();
  }

  void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  void selectionClick() {
    HapticFeedback.selectionClick();
  }

  void vibrate() {
    HapticFeedback.vibrate();
  }

  // Custom methods for more granular control
  void customImpact({required int duration, required int amplitude}) {
    if (duration <= 0 || amplitude <= 0) {
      return;
    }
    HapticFeedback.vibrate();
    Future.delayed(Duration(milliseconds: duration), () {
      HapticFeedback.vibrate();
    });
  }

  void patternFeedback(List<int> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      Future.delayed(Duration(milliseconds: pattern[i]), () {
        HapticFeedback.vibrate();
      });
    }
  }

  void doubleTap() {
    lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      lightImpact();
    });
  }

  void tripleTap() {
    lightImpact();
    Future.delayed(const Duration(milliseconds: 100), () {
      lightImpact();
      Future.delayed(const Duration(milliseconds: 100), () {
        lightImpact();
      });
    });
  }

  // Additional patterns for more complex feedback
  void longPress() {
    heavyImpact();
    Future.delayed(const Duration(milliseconds: 300), () {
      heavyImpact();
    });
  }

  void shortBurst() {
    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        lightImpact();
      });
    }
  }

  void quickVibrate() {
    vibrate();
    Future.delayed(const Duration(milliseconds: 50), () {
      vibrate();
    });
  }

  void customPattern(List<int> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      Future.delayed(Duration(milliseconds: pattern[i]), () {
        vibrate();
      });
    }
  }

  void repeatingPattern(List<int> pattern, int repeatCount) {
    for (int j = 0; j < repeatCount; j++) {
      for (int i = 0; i < pattern.length; i++) {
        Future.delayed(Duration(milliseconds: pattern[i] + (j * pattern.fold(0, (a, b) => a + b))), () {
          vibrate();
        });
      }
    }
  }

  // Additional Preset Feedback Types
  void successFeedback() {
    selectionClick();
    Future.delayed(const Duration(milliseconds: 50), lightImpact);
  }

  void errorFeedback() {
    heavyImpact();
    Future.delayed(const Duration(milliseconds: 100), mediumImpact);
  }

  void warningFeedback() {
    mediumImpact();
    Future.delayed(const Duration(milliseconds: 50), lightImpact);
  }

  // Advanced Custom Feedback
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

  // Haptic Feedback with Varying Intensity
  void crescendoFeedback() {
    for (int i = 1; i <= 5; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        customImpact(duration: 1, amplitude: i * 50); // Increase amplitude over time
      });
    }
  }
}
