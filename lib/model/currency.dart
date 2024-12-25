import 'dart:convert';

class Currency {
  int? currencyId;
  String? currencyName;
  String? currencySymbol;

  Currency({
    this.currencyId,
    this.currencyName,
    this.currencySymbol,
  });

  factory Currency.map(Map<String, dynamic> json) {
    return Currency(
      currencyId: json['currencyId'],
      currencyName: json['currencyName'],
      currencySymbol: json['currencySymbol'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currencyId': currencyId,
      'currencyName': currencyName,
      'currencySymbol': currencySymbol,
    };
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) => Currency.map(json.decode(source));
}
