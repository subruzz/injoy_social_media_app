import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Exporting the generated localization class for easier access.
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension to provide convenient access to localization resources.
extension AppLocalizationsX on BuildContext {
  /// Retrieves the current [AppLocalizations] instance for the given context.
  ///
  /// This extension allows you to access localization strings 
  /// directly from the build context, making it easier to use 
  /// localized strings in your widgets.
  ///
  /// Example:
  /// ```dart
  /// Text(context.l10n.welcomeMessage);
  /// ```
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
