part of pragma_app.modules.auth.ui.pages;

class LogOutPage extends StatelessWidget {
  const LogOutPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      child: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('Has cerrado correctamente tu sesión'),
        ),
      ),
    );
  }
}
