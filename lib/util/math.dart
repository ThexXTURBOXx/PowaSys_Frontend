int signum(double num) {
  if (num < 0) {
    return -1;
  } else if (num == 0) {
    return 0;
  } else {
    return 1;
  }
}

extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? isUtc,
  }) => (isUtc ?? this.isUtc)
      ? DateTime.utc(
          year ?? this.year,
          month ?? this.month,
          day ?? this.day,
          hour ?? this.hour,
          minute ?? this.minute,
          second ?? this.second,
          millisecond ?? this.millisecond,
          microsecond ?? this.microsecond,
        )
      : DateTime(
          year ?? this.year,
          month ?? this.month,
          day ?? this.day,
          hour ?? this.hour,
          minute ?? this.minute,
          second ?? this.second,
          millisecond ?? this.millisecond,
          microsecond ?? this.microsecond,
        );

  DateTime get atStartOfDay =>
      copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

  DateTime get atEndOfDay =>
      copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
}
