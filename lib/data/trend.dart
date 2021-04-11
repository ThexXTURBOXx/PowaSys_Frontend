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
}
