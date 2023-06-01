import 'package:flutter/material.dart';
import '../abstractions/artifact.dart';
import '../ui/widgets/button.dart';

class ButtonArtifact extends Artifact {
  ButtonArtifact() {
    body = _buildButton();
  }
  Widget _buildButton() {
    return Button(
      title: 'Button Artifact',
      width: width,
      height: heigth,
      radius: radius,
      type: 'primary',
      onPressed: null,
    );
  }

  @override
  double heigth = 40.0;

  @override
  double radius = 10.0;

  @override
  double width = 140.0;

  @override
  Widget body = const SizedBox.shrink();
}
