import 'package:challenge/app/core/widgets/cos_snack_bar/cos_snack_bar_widget.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:flutter/material.dart';

class CosSnackBarSuccessWidget extends CosSnackBarWidget {
  const CosSnackBarSuccessWidget({
    super.key,
    required super.content,
    super.backgroundColor = CosTheme.greenAlert,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      backgroundColor: CosTheme.greenAlert,
    );
  }
}
