import 'package:intl/intl.dart';

class HumanFormats {

  static String number( double number ) {
    final formatterNumber = NumberFormat.compactCurrency(
      // configuración
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);

    return formatterNumber;
  }

}