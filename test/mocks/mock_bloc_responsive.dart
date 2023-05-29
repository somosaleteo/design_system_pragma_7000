import 'dart:async';

import 'package:aleteo_arquetipo/blocs/bloc_responsive.dart';
import 'package:flutter/material.dart';

class MockResponsiveBloc implements ResponsiveBloc {
  MockResponsiveBloc({
    Size size = const Size(1, 1),
    bool isMovil = false,
    bool isTablet = false,
    bool isDesktop = false,
    bool isTv = false,
  }) {
    _size = size;
    _isMovil = isMovil;
    _isTablet = isTablet;
    _isDesktop = isDesktop;
    _isTv = isTv;
  }
  late Size _size;
  late bool _isMovil;
  late bool _isTablet;
  late bool _isDesktop;
  late bool _isTv;

  @override
  Stream<Size> get appScreenSizeStream => const Stream<Size>.empty();

  @override
  Size get value => _size;

  @override
  void setSizeFromContext(BuildContext context) {}

  @override
  void setSizeForTesting(Size sizeTmp) {
    _size = sizeTmp;
  }

  @override
  Size get size => _size;

  @override
  set workAreaSize(Size sizeOfWorkArea) {
    _size = sizeOfWorkArea;
  }

  @override
  Size get workAreaSize => _size;

  @override
  int get columnsNumber {
    int tmp = 4;
    if (_isTablet) {
      tmp = 8;
    }
    if (_isDesktop) {
      tmp = 12;
    }
    if (_isTv) {
      tmp = 12;
    }
    return tmp;
  }

  @override
  double get marginWidth {
    double tmp = 16.0;
    if (_isTablet) {
      tmp = 32;
    }
    if (_isDesktop) {
      tmp = 64;
    }
    if (_isTv) {
      tmp = 128;
    }
    return tmp;
  }

  @override
  double get gutterWidth {
    double tmp = marginWidth * 2;
    tmp = tmp / columnsNumber;
    return tmp.floorToDouble();
  }

  @override
  int numberOfGutters(int numberOfColumns) {
    if (numberOfColumns < 1) {
      return 0;
    }
    return numberOfColumns - 1;
  }

  @override
  double get columnWidth {
    double tmp = workAreaSize.width;
    tmp = tmp - (marginWidth * 2);
    tmp = tmp - (numberOfGutters(columnsNumber) * gutterWidth);
    tmp = tmp / columnsNumber;
    return tmp;
  }

  @override
  ScreenSizeEnum get getDeviceType {
    if (_size.width >= 1200) {
      return ScreenSizeEnum.desktop;
    } else if (_size.width < 1200 && _size.width > 520) {
      return ScreenSizeEnum.tablet;
    }
    return ScreenSizeEnum.movil;
  }

  @override
  bool get isMovil => _isMovil;

  @override
  bool get isTablet => _isTablet;

  @override
  bool get isDesktop => _isDesktop;

  @override
  bool get isTv => _isTv;

  @override
  double widthByColumns(int numberOfColumns) {
    numberOfColumns = numberOfColumns.abs();
    double tmp = columnWidth * numberOfColumns;
    if (numberOfColumns > 1) {
      tmp = tmp + (gutterWidth * (numberOfColumns - 1));
    }
    return tmp;
  }

  @override
  FutureOr<void> dispose() {
// implementar logica de limpieza aqui
  }

  set isMovil(bool bool) {
    _isMovil = bool;
  }
}
