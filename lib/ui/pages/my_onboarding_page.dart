import 'package:flutter/material.dart';

import '../../blocs/bloc_responsive.dart';
import '../../blocs/onboarding_bloc.dart';

class MyOnboardingPage extends StatefulWidget {
  const MyOnboardingPage({
    required this.onboardingBloc,
    required this.responsiveBloc,
    super.key,
  });
  final OnboardingBloc onboardingBloc;
  final ResponsiveBloc responsiveBloc;

  @override
  State<MyOnboardingPage> createState() => _MyOnboardingPageState();
}

class _MyOnboardingPageState extends State<MyOnboardingPage> {
  @override
  void initState() {
    super.initState();
    widget.onboardingBloc.execute(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.responsiveBloc.setSizeFromContext(context);
    return Scaffold(
      body: StreamBuilder<String>(
        stream: widget.onboardingBloc.msgStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(),
              const CircularProgressIndicator(),
              Text(widget.onboardingBloc.msg)
            ],
          );
        },
      ),
    );
  }
}
