part of pragma_app.modules.data_base.services;

abstract class MyDBExceptions implements Exception {
  final Map<String, dynamic> data;
  MyDBExceptions(this.data);

  @override
  String toString() {
    return '${super.toString()} with data: ${data.toString()}';
  }
}

class DBException401 implements MyDBExceptions {
  @override
  final Map<String, dynamic> data;
  DBException401(this.data);
}

class DBException3 implements MyDBExceptions {
  @override
  final Map<String, dynamic> data;
  DBException3(this.data);
}

class DBException403 implements MyDBExceptions {
  @override
  final Map<String, dynamic> data;
  DBException403(this.data);
}

class DBException404 implements MyDBExceptions {
  @override
  final Map<String, dynamic> data;
  DBException404(this.data);
}

class DBException500 implements MyDBExceptions {
  @override
  final Map<String, dynamic> data;
  DBException500(this.data);
}

class DBException implements MyDBExceptions {
  @override
  final Map<String, dynamic> data;
  DBException(this.data);
}

class ErrorHandlingService {
  ErrorHandlingService({
    required this.navigatorBloc,
    //required this.authBloc,
  });

  final NavigatorBloc navigatorBloc;
  //final AuthBloc authBloc;

  Exception launchAlertError(Map<String, dynamic> error) {
    final Exception ex;
    switch (error["code"]) {
      case 3:
        ex = DBException3({
          'icon': Icons.logout,
          'title': error["status"],
          'description': error["message"],
        });

        break;
      case 401:
        ex = DBException401({
          'error': error["code"],
          'icon': Icons.logout,
          'title': error["status"],
          'description': error["message"],
        });

        break;
      case 403:
        ex = DBException403({
          'error': error["code"],
          'icon': Icons.logout,
          'title': error["status"],
          'description': error["message"],
        });

        break;
      case 404:
        ex = DBException404({
          'error': error["code"],
          'icon': Icons.logout,
          'title': error["status"],
          'description': error["message"],
        });
        break;
      case 500:
        ex = DBException500({
          'error': error["code"],
          'icon': Icons.logout,
          'title': error["status"],
          'description': error["message"],
        });

        break;
      default:
        ex = DBException({
          'error': error["code"],
          'icon': Icons.logout,
          'title': error["status"],
          'description': error["message"],
        });
    }

    return ex;
  }
}
