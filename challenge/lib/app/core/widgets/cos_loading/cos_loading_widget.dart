import 'package:challenge/app/design/global_theme.dart';
import 'package:flutter/material.dart';

class CosLoadingWidget extends StatelessWidget {
  const CosLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: GlobalTheme.yellowDark,
    );
  }
}
