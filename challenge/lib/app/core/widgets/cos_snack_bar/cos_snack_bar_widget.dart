import 'package:flutter/material.dart';

class CosSnackBarWidget extends SnackBar {
  const CosSnackBarWidget({
    super.key,
    required super.content,
    super.backgroundColor,
  });

  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
    );
  }
}
