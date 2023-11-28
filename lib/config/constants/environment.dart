import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDBKey = dotenv.env['MOVIE_KEY'] ?? 'No hay';
}