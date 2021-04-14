import 'package:flutter/widgets.dart';

void navigateTo(BuildContext context, String name) {
  final r = ModalRoute.of(context);
  if (r == null || r.settings.name != name) {
    Navigator.pushNamedAndRemoveUntil(context, name, (route) => false);
  }
}
