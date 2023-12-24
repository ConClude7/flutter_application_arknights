class HHTimeUtil {
  static String getYMDHMS(int? timeStemp) {
    if (timeStemp == null || timeStemp == 0) {
      return '';
    }
    return '${getYMD(timeStemp)} ${getHMS(timeStemp)}';
  }

  static String getYMD(int timeStemp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeStemp);
    final ymd =
        '${fillZero(date.year)}年${fillZero(date.month)}月${fillZero(date.day)}日';
    return ymd;
  }

  static String getHMS(int timeStemp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timeStemp);
    final hms =
        '${fillZero(date.hour)}时${fillZero(date.minute)}分${fillZero(date.second)}秒';
    return hms;
  }

  static String fillZero(int number) {
    return number > 9 ? '$number' : '0$number';
  }
}
