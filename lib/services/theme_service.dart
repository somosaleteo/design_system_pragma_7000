import 'dart:math';

import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  ThemeService({
    required this.lightColorScheme,
    required this.darkColorScheme,
    required this.colorSeed,
    this.textTheme,
  }) {
    _themeValuenotifier = ValueNotifier<ThemeData>(
      customThemeFromColorScheme(
        lightColorScheme,
        textTheme ?? const TextTheme(),
      ),
    );
  }

  final ColorScheme lightColorScheme, darkColorScheme;
  final Color colorSeed;
  final TextTheme? textTheme;

  bool isDark = false;
  late ValueNotifier<ThemeData> _themeValuenotifier;

  ValueNotifier<ThemeData> get themeValuenotifier => _themeValuenotifier;

  ThemeData get theme => _themeValuenotifier.value;
  set theme(ThemeData themeData) {
    _themeValuenotifier.value = themeData;
  }

  void switchLightAndDarkTheme() {
    isDark = !isDark;
    isDark
        ? theme = customThemeFromColorScheme(
            darkColorScheme,
            ThemeData.dark().textTheme,
            isDark,
          )
        // GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme), isDark)
        : theme = customThemeFromColorScheme(
            lightColorScheme,
            ThemeData.light().textTheme,
          );
    notifyListeners();
  }
}

/// [materialColorFromRGB] Returns a [MaterialColor] generated from the given RGB values.
///
/// The function creates a map of 10 different shades of the color,
/// ranging from lightest to darkest. The resulting [MaterialColor] is
/// created using the darkest shade as the primary color and the map
/// of shades as the swatch.
///
/// The RGB values must be integers between 0 and 255, inclusive.
///
/// Example:
///
/// ```dart
/// MaterialColor myColor = materialColorFromRGB(128, 0, 128);
/// ```
///
/// This will create a `MaterialColor` object representing a purple color
/// with a primary value of `Color(0xff800080)` and swatches ranging
/// from `50` to `900`.
MaterialColor materialColorFromRGB(int r, int g, int b) {
  MaterialColor colorJ = Colors.orange;
  try {
    final Map<int, Color> colorMap = <int, Color>{
      50: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .55),
      100: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .45),
      200: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .35),
      300: getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .25),
      400: getLighter(Color.fromRGBO(r, g, b, 1.0)),
      500: Color.fromRGBO(r, g, b, 1.0),
      600: getDarker(Color.fromRGBO(r, g, b, 1.0)),
      700: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .15),
      800: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .25),
      900: getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .375),
    };

    colorJ = MaterialColor(
      int.parse(
        Color.fromRGBO(r, g, b, 1.0)
            .toString()
            .replaceAll('Color(', '')
            .replaceAll(')', '')
            .substring(2),
        radix: 16,
      ),
      colorMap,
    );
  } catch (e) {
    colorJ = Colors.orange;
  }
  return colorJ;
}

/// [getDarker] Returns a darker version of the given [color] by the specified
/// [amount].
/// The [amount] parameter should be between 0 and 1, with a default value of 0.1.
///
/// Throws an [AssertionError] if the [amount] parameter is outside the valid range.
///
/// Example:
///
/// ```dart
/// final darkerColor = getDarker(Colors.blue, amount: 0.2);
/// ```
Color getDarker(Color color, {double amount = .1}) {
  assert(amount >= 0 && amount <= 1);

  final HSLColor hsl = HSLColor.fromColor(color);
  final HSLColor hslDark =
      hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
  return hslDark.toColor();
}

/// Returns a lighter [Color] based on the provided [color] and [amount].
/// The optional [amount] parameter controls the amount of lightness to add.
///
/// Throws an [AssertionError] if [amount] is not within the valid range of 0.0 to 1.0.
///
/// Example:
///
/// ```dart
/// Color baseColor = Colors.blue;
/// Color lighterColor = getLighter(baseColor, amount: 0.3);
/// ```
Color getLighter(Color color, {double amount = .1}) {
  assert(amount >= 0 && amount <= 1);

  final HSLColor hsl = HSLColor.fromColor(color);
  final HSLColor hslLight =
      hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
  return hslLight.toColor();
}

/// [customThemeFromColorScheme] Creates a custom `ThemeData` from a given `ColorScheme` and `TextTheme`.
///
/// If `isDark` is `true`, the theme will have `Brightness.dark`, otherwise `Brightness.light`.
///
/// Example usage:
/// ```dart
/// final colorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.blue);
/// final textTheme = TextTheme(bodyText2: TextStyle(fontSize: 16));
/// final themeData = customThemeFromColorScheme(colorScheme, textTheme, false);
/// ```
///
/// See also:
///
/// * `ThemeData`, a class that describes the complete theme for a Material Design application.
/// * `ColorScheme`, a class that defines a color scheme based on a primary color.
/// * `materialColorFromRGB`, a function that generates a `MaterialColor` from RGB values.
ThemeData customThemeFromColorScheme(
  ColorScheme colorScheme,
  TextTheme textTheme, [
  bool isDark = false,
]) {
  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    brightness: isDark ? Brightness.dark : Brightness.light,
    primarySwatch: materialColorFromRGB(
      colorScheme.primary.red,
      colorScheme.primary.green,
      colorScheme.primary.blue,
    ),
  );
}

/// [ThemeChangerWidget] An [InheritedWidget] that provides access to the [ThemeService] for the app.
///
/// This widget can be used to get the current [ThemeService] instance from
/// anywhere in the widget tree below it. When the theme changes, this widget
/// will rebuild all the children that depend on it.
class ThemeChangerWidget extends InheritedWidget {
  /// Creates a [ThemeChangerWidget].
  ///
  /// [themeService] must not be null.
  const ThemeChangerWidget({
    required this.themeService,
    required super.child,
    super.key,
  });

  /// The [ThemeService] instance provided by this widget.
  final ThemeService themeService;

  /// Returns the [ThemeChangerWidget] instance from the nearest ancestor
  /// [ThemeChangerWidget] in the widget tree.
  ///
  /// Throws an [AssertionError] if no [ThemeChangerWidget] is found in the
  /// widget tree.
  static ThemeChangerWidget of(BuildContext context) {
    final ThemeChangerWidget? result =
        context.dependOnInheritedWidgetOfExactType<ThemeChangerWidget>();
    assert(result != null, 'No ThemeChangerData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

/// A utility class that provides helper methods for working with colors.
class ThemeHelpers {
  /// [colorRandom] Returns a randomly generated color.
  /// Example usage:
  ///
  /// ```dart
  /// // Import the ThemeHelpers class
  /// import 'package:my_app/theme_helpers.dart';
  ///
  /// // Use the colorRandom() method to generate a random color
  /// Color myRandomColor = ThemeHelpers.colorRandom();
  /// ```
  static Color colorRandom() {
    final Random random = Random();
    final int r = random.nextInt(255);
    final int g = random.nextInt(255);
    final int b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }

  /// [validateHexColor] Validates a hexadecimal color string.
  ///
  /// Returns true if the provided string is a valid hexadecimal color string,
  /// and false otherwise.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// if (ThemeHelpers.validateHexColor('#FFFFFF')) {
  ///   print('Valid color!');
  /// } else {
  ///   print('Invalid color!');
  /// }
  /// ```
  static bool validateHexColor(String colorHex) {
    bool colorValido = false;

    const Pattern colorPattern = r'^#(?:[0-9a-fA-F]{3}){1,2}$';
    final RegExp regExp = RegExp(colorPattern as String);
    if (regExp.hasMatch(colorHex)) {
      colorValido = true;
    }
    return colorValido;
  }

  /// [getDarker] Returns a darker shade of the given [color], by the specified [amount].
  ///
  /// The [amount] should be a value between 0 and 1, where 0 is the original color
  /// and 1 is completely black.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// Color originalColor = Colors.blue;
  /// Color darkerColor = ThemeHelpers.getDarker(originalColor, amount: 0.2);
  /// ```
  static Color getDarker(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor hslDark =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// [getLighter] Returns a lighter version of the given [color].
  ///
  /// The [amount] parameter controls the amount of lightness added to the color.
  /// It should be a value between 0.0 and 1.0, where 0.0 represents no added lightness
  /// (i.e., the original color), and 1.0 represents maximum added lightness (i.e., white).
  /// Example usage:
  ///
  /// ```
  /// final primaryColor = Colors.blue;
  /// final lighterPrimaryColor = ThemeHelpers.getLighter(primaryColor, amount: 0.2);
  ///
  /// return MaterialApp(
  ///   theme: ThemeData(
  ///     primaryColor: primaryColor,
  ///     accentColor: lighterPrimaryColor,
  ///   ),
  ///   home: MyHomePage(),
  /// );
  /// ```
  static Color getLighter(Color color, {double amount = .1}) {
    assert(amount >= 0 && amount <= 1);

    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  /// [materialColorFromRGB] Creates a [MaterialColor] with shades of the specified RGB color.
  ///
  /// The returned [MaterialColor] will have 10 shades, ranging from 50 to 900,
  /// with lighter shades towards 50 and darker shades towards 900.
  ///
  /// The `r`, `g`, and `b` values should be integers between 0 and 255.
  ///
  /// Throws an [AssertionError] if `amount` is not between 0 and 1.
  static MaterialColor materialColorFromRGB(int r, int g, int b) {
    MaterialColor colorJ = Colors.orange;
    try {
      final Map<int, Color> colorMap = <int, Color>{
        50: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .55),
        100: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .45),
        200: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .35),
        300: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0), amount: .25),
        400: ThemeHelpers.getLighter(Color.fromRGBO(r, g, b, 1.0)),
        500: Color.fromRGBO(r, g, b, 1.0),
        600: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0)),
        700: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .15),
        800: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .25),
        900: ThemeHelpers.getDarker(Color.fromRGBO(r, g, b, 1.0), amount: .375),
      };

      colorJ = MaterialColor(
        int.parse(
          Color.fromRGBO(r, g, b, 1.0)
              .toString()
              .replaceAll('Color(', '')
              .replaceAll(')', '')
              .substring(2),
          radix: 16,
        ),
        colorMap,
      );
    } catch (e) {
      colorJ = Colors.orange;
    }

    return colorJ;
  }

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFA6C8FF),
    onPrimary: Color(0xFF003063),
    primaryContainer: Color(0xFF00468B),
    onPrimaryContainer: Color(0xFFD4E3FF),
    secondary: Color(0xFFBDC7DC),
    onSecondary: Color(0xFF273141),
    secondaryContainer: Color(0xFF3D4758),
    onSecondaryContainer: Color(0xFFD9E3F8),
    tertiary: Color(0xFFDBBDE1),
    onTertiary: Color(0xFF3E2845),
    tertiaryContainer: Color(0xFF563E5D),
    onTertiaryContainer: Color(0xFFF8D8FE),
    error: Color(0xFFFFB4A9),
    errorContainer: Color(0xFF930006),
    onError: Color(0xFF680003),
    onErrorContainer: Color(0xFFFFDAD4),
    background: Color(0xFF1B1B1D),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1B1B1D),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF43474F),
    onSurfaceVariant: Color(0xFFC3C6CF),
    outline: Color(0xFF8E919A),
    onInverseSurface: Color(0xFF1B1B1D),
    inverseSurface: Color(0xFFE3E2E6),
    inversePrimary: Color(0xFF245FA7),
    shadow: Color(0xFF000000),
  );

  static MaterialColor materialColorFromColor(Color color) {
    return materialColorFromRGB(color.red, color.green, color.blue);
  }
}
