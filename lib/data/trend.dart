import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:powasys_frontend/constants.dart';
import 'package:powasys_frontend/generated/l10n.dart';
import 'package:sprintf/sprintf.dart';

enum Trend {
  state(id: 'state'),
  genVoltage(id: 'genVoltage'),
  genCurrent(id: 'genCurrent'),
  genPower(id: 'genPower'),
  netVoltage(id: 'netVoltage'),
  netCurrent(id: 'netCurrent'),
  netPower(id: 'netPower'),
  temperature(id: 'temperature');

  final String id;

  const Trend({required this.id});

  String name(BuildContext context) {
    switch (this) {
      case Trend.state:
        return S.of(context).state;
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
      case Trend.state:
        return '';
      case Trend.genVoltage:
      case Trend.netVoltage:
        return S.of(context).voltage_unit;
      case Trend.genCurrent:
      case Trend.netCurrent:
        return S.of(context).current_unit;
      case Trend.genPower:
      case Trend.netPower:
        return S.of(context).power_unit;
      case Trend.temperature:
        return S.of(context).temperature_unit;
    }
  }

  num parse(String? str) {
    switch (this) {
      case Trend.state:
      case Trend.genPower:
      case Trend.netPower:
      case Trend.temperature:
        return str == null ? 0 : int.parse(str);
      case Trend.genVoltage:
      case Trend.netVoltage:
      case Trend.genCurrent:
      case Trend.netCurrent:
        return str == null ? 0 : double.parse(str);
    }
  }

  String format(BuildContext context, num? value) {
    if (value == null) {
      return '';
    } else {
      return sprintf(
        S.of(context).amount_format,
        [formatNum(context, value), unit(context)],
      );
    }
  }
}
