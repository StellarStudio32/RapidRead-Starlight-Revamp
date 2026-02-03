/// This file centralizes application-wide constants.
/// Using a dedicated file for constants helps avoid "magic numbers" or
/// hardcoded strings in the codebase, making it more maintainable and
/// less prone to errors. It adheres to the DRY (Don't Repeat Yourself) principle.
class AppConstants {
  // Private constructor to prevent instantiation.
  AppConstants._();

  static const double minDesktopWidth = 800.0;
  static const double minDesktopHeight = 600.0;
}
