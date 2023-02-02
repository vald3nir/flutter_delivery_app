import 'package:intl/intl.dart';

extension FormatterExtension on double {
  String get currencyTPBR {
    final currencyFormat = NumberFormat.currency(
      locale: 'pt_br',
      symbol: r'R$',
    );
    return currencyFormat.format(this);
  }
}
