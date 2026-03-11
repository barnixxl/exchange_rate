class CurrencyApiResponse {
  final String date;
  final Map<String, dynamic> rates;

  CurrencyApiResponse({
    required this.date,
    required this.rates,
  });

  factory CurrencyApiResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyApiResponse(
      date: json['date'] ?? DateTime.now().toIso8601String(),
      rates: json['rates'] as Map<String, dynamic>? ?? {},
    );
  }
}
