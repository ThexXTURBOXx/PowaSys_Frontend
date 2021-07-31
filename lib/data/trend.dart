import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/generated/l10n.dart';

enum Trend {
  VOLTAGE,
  CURRENT,
  POWER,
  TEMPERATURE,
}

extension TrendMeta on Trend {
  String name(BuildContext context) {
    switch (this) {
      case Trend.VOLTAGE:
        return S.of(context).voltage;
      case Trend.CURRENT:
        return S.of(context).current_;
      case Trend.POWER:
        return S.of(context).power;
      case Trend.TEMPERATURE:
        return S.of(context).temperature;
    }
  }

  String unit(BuildContext context) {
    switch (this) {
      case Trend.VOLTAGE:
        return S.of(context).voltage_unit;
      case Trend.CURRENT:
        return S.of(context).current_unit;
      case Trend.POWER:
        return S.of(context).power_unit;
      case Trend.TEMPERATURE:
        return S.of(context).temperature_unit;
    }
  }

  Color get color {
    switch (this) {
      case Trend.VOLTAGE:
        return Colors.indigo;
      case Trend.CURRENT:
        return Colors.lightBlueAccent;
      case Trend.POWER:
        return Colors.deepOrangeAccent;
      case Trend.TEMPERATURE:
        return Colors.greenAccent;
    }
  }
}
