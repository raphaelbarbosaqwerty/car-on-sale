import 'package:challenge/app/core/widgets/cos_snack_bar/cos_snack_bar_widget.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:flutter/material.dart';

class CosSnackBarErrorWidget extends CosSnackBarWidget {
  const CosSnackBarErrorWidget({
    super.key,
    required super.content,
    super.backgroundColor = CosTheme.redAlert,
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      backgroundColor: CosTheme.redAlert,
    );
  }
}
