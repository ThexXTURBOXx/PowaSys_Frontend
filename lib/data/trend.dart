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

extension TrendMeta on Trend {
  String name(BuildContext context) {
    switch (this) {
      case Trend.genVoltage:
        return S.of(context).genVoltage;
      case Trend.genCurrent:
        return S.of(context).genCurrent;
      case Trend.genPower:
        return S.of(context).genPower;
      case Trend.netVoltage:
        return S.of(context).netVoltage;
      case Trend.netCurrent:
        return S.of(context).netCurrent;
      case Trend.netPower:
        return S.of(context).netPower;
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
