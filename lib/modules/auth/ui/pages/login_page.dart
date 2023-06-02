part of pragma_app.modules.auth.ui.pages;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = blocCore.getBlocModule<AuthBloc>(AuthBloc.name);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo.png',
              width: 171,
            ),
            Text(
              'Somos pilotos',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'de nuestro destino',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('LoginPage_ElevatedButton_GoogleLogin'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).buttonTheme.colorScheme!.surfaceTint,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () async {
                await authBloc.onLogIn();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/img/google_logo.png',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Iniciar sesión con Google',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
