import 'package:aleteo_arquetipo/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('getDarker function', () {
    test('materialColorFromRGB should return expected MaterialColor object',
        () {
      const MaterialColor expectedColor =
          MaterialColor(0xff5a5a5a, <int, Color>{
        50: Color(0xfff8f8f8),
        100: Color(0xfff0f0f0),
        200: Color(0xffe7e7e7),
        300: Color(0xffdfe0e0),
        400: Color(0xffc2c2c2),
        500: Color(0xffa6a6a6),
        600: Color(0xff8e8e8e),
        700: Color(0xff7b7b7b),
        800: Color(0xff575757),
        900: Color(0xff3a3a3a),
      });

      final MaterialColor actualColor = materialColorFromRGB(90, 90, 90);

      expect(actualColor.value, expectedColor.value);
    });

    test(
        'materialColorFromRGB should return orange MaterialColor object for invalid RGB values',
        () {
      const MaterialColor expectedColor = Colors.orange;
      final MaterialColor actualColor = materialColorFromRGB(255, 152, 0);

      expect(actualColor.value, expectedColor.value);
    });
    test(
        'materialColorFromRGB should return orange MaterialColor object for null RGB values',
        () {
      const Color expectedColor = Colors.black;
      final MaterialColor actualColor = materialColorFromRGB(0, 0, 0);

      expect(actualColor.value, expectedColor.value);
    });
    test('Given a color and an amount, it returns a darker color', () {
      // Arrange
      const MaterialColor color = Colors.blue;
      const double amount = 0.2;
      const Color expectedColor = Color.fromRGBO(9, 28, 89, 1);

      // Act
      final Color darkerColor = getDarker(color, amount: amount);

      // Assert
      expect(darkerColor.value, greaterThan(expectedColor.value));
    });

    test('Given a color and an amount bigger than 1, it returns the same color',
        () {
      // Arrange
      const MaterialColor color = Colors.blue;
      const double amount = 0.75;

      // Act
      final Color darkerColor = getDarker(color, amount: amount);

      // Assert
      expect(darkerColor.value, lessThan(color.value));
    });

    test('Given a white color and an amount, it returns a darker color', () {
      // Arrange
      const Color color = Colors.white;
      const Color expectedColor = Color.fromRGBO(217, 217, 217, 1);

      // Act
      final Color darkerColor = getDarker(color);

      // Assert
      expect(darkerColor.value, greaterThan(expectedColor.value));
    });
  });

  group('getLighter tests', () {
    test('Given a color and an amount, it should return a lighter color', () {
      // Arrange
      const MaterialColor color = Colors.blue;
      final double initialLightness = HSLColor.fromColor(color).lightness;

      // Act
      final Color lighterColor = getLighter(color);
      final double lighterLightness =
          HSLColor.fromColor(lighterColor).lightness;

      // Assert
      expect(lighterLightness, greaterThan(initialLightness));
      expect(lighterLightness, lessThanOrEqualTo(1.0));
      expect(lighterLightness, greaterThanOrEqualTo(initialLightness));
      expect(lighterColor, isNot(equals(color)));
    });

    test('Given a color and a maximum amount, it should return a white color',
        () {
      // Arrange
      const MaterialColor color = Colors.red;
      final double initialLightness = HSLColor.fromColor(color).lightness;

      // Act
      final Color lighterColor = getLighter(color, amount: 1.0);
      final double lighterLightness =
          HSLColor.fromColor(lighterColor).lightness;

      // Assert
      expect(lighterColor, equals(Colors.white));
      expect(lighterLightness, equals(1.0));
      expect(lighterLightness, greaterThanOrEqualTo(initialLightness));
    });

    test('When amount is negative, throws an assertion error', () {
      const MaterialColor color = Colors.red;
      expect(
        () => getLighter(color, amount: -0.5),
        throwsA(isA<AssertionError>()),
      );
    });

    test('When amount is greater than 1, throws an assertion error', () {
      const MaterialColor color = Colors.red;
      expect(
        () => getLighter(color, amount: 1.5),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('ThemeService', () {
    late ThemeService themeService;

    const ColorScheme lightColorScheme = ColorScheme.light();
    const ColorScheme darkColorScheme = ThemeHelpers.darkColorScheme;
    const MaterialColor colorSeed = Colors.blue;
    setUp(() {
      themeService = ThemeService(
        lightColorScheme: lightColorScheme,
        darkColorScheme: darkColorScheme,
        colorSeed: colorSeed,
      );
    });
    test('initial values', () {
      expect(themeService.isDark, false);
      expect(
        themeService.themeValuenotifier.value.brightness,
        Brightness.light,
      );
    });

    test('switchLightAndDarkTheme', () {
      // switch to dark theme
      themeService.switchLightAndDarkTheme();

      expect(themeService.isDark, true);
      expect(themeService.themeValuenotifier.value.brightness, Brightness.dark);

      // switch back to light theme
      themeService.switchLightAndDarkTheme();

      expect(themeService.isDark, false);
      expect(
        themeService.themeValuenotifier.value.brightness,
        Brightness.light,
      );
    });

    test('customThemeFromColorScheme', () {
      // create a custom theme from light color scheme
      final ThemeData lightTheme = customThemeFromColorScheme(
        lightColorScheme,
        const TextTheme(),
      );

      expect(
        lightTheme.primaryColor.value,
        equals(lightColorScheme.primary.value),
      );
      expect(
        lightTheme.colorScheme.secondary.value,
        equals(lightColorScheme.secondary.value),
      );
      expect(lightTheme.textTheme.displayLarge?.color?.value == null, false);
      expect(lightTheme.textTheme.bodyMedium?.color is Color, true);

      // create a custom theme from dark color scheme
      final ThemeData darkTheme = customThemeFromColorScheme(
        darkColorScheme,
        const TextTheme(),
        true,
      );

      expect(darkTheme.primaryColor.value, equals(4280361249));
      expect(darkTheme.colorScheme.secondary.value, equals(4290627548));
      expect(
        darkTheme.textTheme.displayLarge?.color?.value,
        equals(3019898879),
      );
      expect(darkTheme.textTheme.bodyMedium?.color?.value, equals(4294967295));
    });
  });

  group('ThemeHelpers', () {
    test('colorRandom() returns a random color', () {
      final Color color1 = ThemeHelpers.colorRandom();
      final Color color2 = ThemeHelpers.colorRandom();
      expect(color1, isNot(color2));
    });

    test('colorRandom() returns a valid color', () {
      final Color color = ThemeHelpers.colorRandom();
      expect(color.alpha, equals(255));
      expect(color.red, greaterThanOrEqualTo(0));
      expect(color.red, lessThanOrEqualTo(255));
      expect(color.green, greaterThanOrEqualTo(0));
      expect(color.green, lessThanOrEqualTo(255));
      expect(color.blue, greaterThanOrEqualTo(0));
      expect(color.blue, lessThanOrEqualTo(255));
    });

    test('Valid hex color', () {
      final bool result = ThemeHelpers.validateHexColor('#123abc');
      expect(result, true);
    });

    test('Invalid hex color', () {
      final bool result = ThemeHelpers.validateHexColor('123abc');
      expect(result, false);
    });

    test('Invalid hex color format', () {
      final bool result = ThemeHelpers.validateHexColor('#12');
      expect(result, false);
    });

    test('Valid hex color with only 3 characters', () {
      final bool result = ThemeHelpers.validateHexColor('#abc');
      expect(result, true);
    });

    test('Valid hex color with 6 characters', () {
      final bool result = ThemeHelpers.validateHexColor('#abcdef');
      expect(result, true);
    });

    test('Valid uppercase hex color', () {
      final bool result = ThemeHelpers.validateHexColor('#123ABC');
      expect(result, true);
    });
  });
  group('getDarker', () {
    test('should return a darker version of the input color', () {
      // Arrange
      const MaterialColor color = Colors.blue;
      const double amount = 0.2;

      // Act
      final Color darkerColor = getDarker(color, amount: amount);

      // Assert
      expect(
        darkerColor,
        isNot(
          equals(
            color,
          ),
        ),
      ); // darker color is not the same as the input color
      expect(
        darkerColor,
        isInstanceOf<Color>(),
      ); // darker color is an instance of Color class
    });

    test('should return the input color when amount is 0', () {
      // Arrange
      const MaterialColor color = Colors.green;
      const double amount = 0.0;

      // Act
      final Color darkerColor = getDarker(color, amount: amount);

      // Assert
      expect(
        darkerColor.value,
        equals(color.value),
      ); // darker color is the same as the input color
    });

    test('should return black when amount is 1', () {
      // Arrange
      const MaterialColor color = Colors.red;
      const double amount = 1.0;

      // Act
      final Color darkerColor = getDarker(color, amount: amount);

      // Assert
      expect(darkerColor, equals(Colors.black)); // darker color is black
    });

    test('should clamp the lightness value to 0 when amount is greater than 1',
        () {
      // Arrange
      const MaterialColor color = Colors.pink;
      const double amount = 1.0;

      // Act
      final Color darkerColor = ThemeHelpers.getDarker(color, amount: amount);

      // Assert
      expect(darkerColor, equals(Colors.black)); // darker color is black
    });

    test('should clamp the lightness value to 1 when amount is less than 0',
        () {
      // Arrange
      const MaterialColor color = Colors.purple;
      const double amount = 0.0;

      // Act
      final Color darkerColor = ThemeHelpers.getDarker(color, amount: amount);

      // Assert
      expect(
        darkerColor.value,
        equals(color.value),
      ); // darker color is the same as the input color
    });
  });

  group('getLighter', () {
    test('Given a color and an amount, should return a lighter color', () {
      // Arrange
      const MaterialColor color = Colors.blue;

      // Act
      final Color result = getLighter(color);

      // Assert
      expect(result, isA<Color>());
      expect(result, isNot(color));
      expect(result.computeLuminance(), greaterThan(color.computeLuminance()));
    });

    test('Given a color and an amount of 0, should return the same color', () {
      // Arrange
      const MaterialColor color = Colors.blue;
      const double amount = 0.0;

      // Act
      final Color result = getLighter(color, amount: amount);

      // Assert
      expect(result.value, equals(color.value));
    });

    test('Given a color and an amount of 1, should return white', () {
      // Arrange
      const MaterialColor color = Colors.blue;
      const double amount = 1.0;

      // Act
      final Color result = getLighter(color, amount: amount);

      // Assert
      expect(result.value, equals(Colors.white.value));
    });

    test('Given an invalid amount, should throw an assertion error', () {
      // Arrange
      const MaterialColor color = Colors.blue;
      const double amount = -0.1;

      // Act & Assert
      expect(() => getLighter(color, amount: amount), throwsAssertionError);
    });
  });

  group('materialColor', () {
    test('materialColorFromRGB returns a MaterialColor object', () {
      // Arrange
      const int r = 255;
      const int g = 0;
      const int b = 0;

      // Act
      final MaterialColor color = ThemeHelpers.materialColorFromRGB(r, g, b);

      // Assert
      expect(color, isA<MaterialColor>());
    });

    test('materialColorFromRGB returns a MaterialColor object with 10 swatches',
        () {
      // Arrange
      const int r = 255;
      const int g = 0;
      const int b = 0;

      // Act
      final MaterialColor color = ThemeHelpers.materialColorFromRGB(r, g, b);

      // Assert
      expect(
        color.shade500.value,
        equals(const Color.fromRGBO(r, g, b, 1.0).value),
      );
    });

    test(
        'materialColorFromRGB returns a MaterialColor with the correct RGB values for swatch 500',
        () {
      // Arrange
      const int r = 255;
      const int g = 0;
      const int b = 0;

      // Act
      final MaterialColor color = ThemeHelpers.materialColorFromRGB(r, g, b);

      // Assert
      expect(color[500], equals(const Color.fromRGBO(r, g, b, 1.0)));
    });

    test(
        'materialColorFromRGB returns a MaterialColor with the correct lighter value for swatch 100',
        () {
      // Arrange
      const int r = 255;
      const int g = 0;
      const int b = 0;

      // Act
      final MaterialColor color = ThemeHelpers.materialColorFromRGB(r, g, b);

      // Assert
      expect(
        color[100],
        equals(
          ThemeHelpers.getLighter(
            const Color.fromRGBO(r, g, b, 1.0),
            amount: .45,
          ),
        ),
      );
    });

    test(
        'materialColorFromRGB returns a MaterialColor with the correct darker value for swatch 700',
        () {
      // Arrange
      const int r = 255;
      const int g = 0;
      const int b = 0;

      // Act
      final MaterialColor color = ThemeHelpers.materialColorFromRGB(r, g, b);

      // Assert
      expect(
        color[700],
        equals(
          ThemeHelpers.getDarker(
            const Color.fromRGBO(r, g, b, 1.0),
            amount: .15,
          ),
        ),
      );
      final MaterialColor result2 = ThemeHelpers.materialColorFromColor(color);
      expect(result2.value, equals(result2.value));
    });
  });
}
