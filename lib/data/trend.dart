import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/generated/l10n.dart';

enum Trend {
  voltage,
  current,
  power,
  temperature,
}

extension TrendMeta on Trend {
  String name(BuildContext context) {
    switch (this) {
      case Trend.voltage:
        return S.of(context).voltage;
      case Trend.current:
        return S.of(context).current_;
      case Trend.power:
        return S.of(context).power;
      case Trend.temperature:
        return S.of(context).temperature;
    }
  }

  String unit(BuildContext context) {
    switch (this) {
      case Trend.voltage:
        return S.of(context).voltage_unit;
      case Trend.current:
        return S.of(context).current_unit;
      case Trend.power:
        return S.of(context).power_unit;
      case Trend.temperature:
        return S.of(context).temperature_unit;
    }
  }

  Color get color {
    switch (this) {
      case Trend.voltage:
        return Colors.indigo;
      case Trend.current:
        return Colors.lightBlueAccent;
      case Trend.power:
        return Colors.deepOrangeAccent;
      case Trend.temperature:
        return Colors.greenAccent;
    }
  }
}
