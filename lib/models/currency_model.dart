class CurrencyModel {
  final String code;
  final String name;
  final double rate;
  final DateTime date;

  CurrencyModel({
    required this.code,
    required this.name,
    required this.rate,
    required this.date,
  });

// использую фабричный метод для облегчения приложения

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      code: json['code'] ?? '',
      name: json['name'] ?? 'данная валюта отсутствует',
      rate: (json['rate'] ?? 0.0).toDouble(),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  String toString() {
    return 'CurrencyModel(code: $code, name: $name, rate: $rate)';
  }
}
