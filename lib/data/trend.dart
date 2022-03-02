import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/generated/l10n.dart';

enum Trend {
  genVoltage,
  genCurrent,
  genPower,
  netVoltage,
  netCurrent,
  netPower,
  temperature,
}

// TODO(Nico): Adjust values here!

extension TrendMeta on Trend {
  String name(BuildContext context) {
    switch (this) {
      case Trend.genVoltage:
        return S.of(context).voltage;
      case Trend.genCurrent:
        return S.of(context).current_;
      case Trend.genPower:
        return S.of(context).power;
      case Trend.netVoltage:
        return S.of(context).voltage;
      case Trend.netCurrent:
        return S.of(context).current_;
      case Trend.netPower:
        return S.of(context).power;
      case Trend.temperature:
        return S.of(context).temperature;
    }
  }

  String unit(BuildContext context) {
    switch (this) {
      case Trend.genVoltage:
        return S.of(context).voltage_unit;
      case Trend.genCurrent:
        return S.of(context).current_unit;
      case Trend.genPower:
        return S.of(context).power_unit;
      case Trend.netVoltage:
        return S.of(context).voltage_unit;
      case Trend.netCurrent:
        return S.of(context).current_unit;
      case Trend.netPower:
        return S.of(context).power_unit;
      case Trend.temperature:
        return S.of(context).temperature_unit;
    }
  }

  Color get color {
    switch (this) {
      case Trend.genVoltage:
        return Colors.indigo;
      case Trend.genCurrent:
        return Colors.lightBlueAccent;
      case Trend.genPower:
        return Colors.deepOrangeAccent;
      case Trend.netVoltage:
        return Colors.indigo;
      case Trend.netCurrent:
        return Colors.lightBlueAccent;
      case Trend.netPower:
        return Colors.deepOrangeAccent;
      case Trend.temperature:
        return Colors.greenAccent;
    }
  }

  String get id {
    switch (this) {
      case Trend.genVoltage:
        return 'genVoltage';
      case Trend.genCurrent:
        return 'genCurrent';
      case Trend.genPower:
        return 'genPower';
      case Trend.netVoltage:
        return 'netVoltage';
      case Trend.netCurrent:
        return 'netCurrent';
      case Trend.netPower:
        return 'netPower';
      case Trend.temperature:
        return 'temperature';
    }
  }
}
