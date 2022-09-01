import 'dart:convert';
import 'dart:html';

import 'package:flutter/widgets.dart';

void navigateTo(BuildContext context, String name) {
  final r = ModalRoute.of(context);
  if (r == null || r.settings.name != name) {
    Navigator.pushNamedAndRemoveUntil(context, name, (route) => false);
  }
}

void downloadBytes(List<int> bytes, String fileName) {
  final content = base64Encode(bytes);
  AnchorElement(
    href: 'data:application/octet-stream;charset=utf-16le;base64,$content',
  )
    ..setAttribute('download', fileName)
    ..click();
}
