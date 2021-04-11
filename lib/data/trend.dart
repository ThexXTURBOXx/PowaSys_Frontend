import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Trend {
  VOLTAGE,
  CURRENT,
  POWER,
  TEMPERATURE,
}

extension TrendMeta on Trend {
  String get name {
    switch (this) {
      case Trend.VOLTAGE:
        return 'voltage';
      case Trend.CURRENT:
        return 'current';
      case Trend.POWER:
        return 'power';
      case Trend.TEMPERATURE:
        return 'temperature';
    }
  }

  String get unit {
    switch (this) {
      case Trend.VOLTAGE:
        return 'voltage_unit';
      case Trend.CURRENT:
        return 'current_unit';
      case Trend.POWER:
        return 'power_unit';
      case Trend.TEMPERATURE:
        return 'temperature_unit';
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
