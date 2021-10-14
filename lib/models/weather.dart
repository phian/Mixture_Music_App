class Weather {
  Weather({
    required this.current,
  });

  late final Current? current;

  Weather.fromJson(Map<String, dynamic> json) {
    current = Current.fromJson(json['current']);
  }

}

class Current {
  Current({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
  });
  late final double tempC;
  late final double tempF;
  late final int isDay;
  late final Condition condition;

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = Condition.fromJson(json['condition']);
  }

}

class Condition {
  Condition({
    required this.text,
    required this.code,
  });
  late final String text;
  late final int code;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    code = json['code'];
  }

}
