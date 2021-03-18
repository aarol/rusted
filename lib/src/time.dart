extension IntTime on int {
  Duration get seconds => Duration(seconds: this);

  Duration get minutes => Duration(minutes: this);

  Duration get milliseconds => Duration(milliseconds: this);
}

extension DoubleTime on double {
  Duration get seconds {
    var millis = this % 1 * 1000;
    return Duration(seconds: toInt(), milliseconds: millis.toInt());
  }

  Duration get minutes {
    var secs = this % 1 * 60;
    return Duration(minutes: toInt(), seconds: secs.toInt());
  }

  Duration get milliseconds {
    var micros = this % 1 * 1000;
    return Duration(milliseconds: toInt(), microseconds: micros.toInt());
  }
}
