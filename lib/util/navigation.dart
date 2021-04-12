import 'package:flutter/widgets.dart';

void navigateTo(BuildContext context, String name) {
  final r = ModalRoute.of(context);
  if (r == null || r.settings.name != '/') {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
