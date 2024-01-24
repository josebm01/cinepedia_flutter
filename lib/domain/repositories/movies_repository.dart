import 'package:cinemapedia/domain/entities/movie.dart';

//? abstract, no se crearán instancias de la clase 
abstract class MoviesRepository {

  // Películas actuales
  Future<List<Movie>> getNowPlaying({ int page = 1 });
  
  // Películas populares
  Future<List<Movie>> getPopular({ int page = 1 });
}
