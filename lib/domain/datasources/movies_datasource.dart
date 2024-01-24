import 'package:cinemapedia/domain/entities/movie.dart';

//? abstract, no se crearán instancias de la clase 
abstract class MoviesDatasource {

  // Películas actuales
  Future<List<Movie>> getNowPlaying({ int page = 1 });

  // Películas populares
  Future<List<Movie>> getPopular({ int page = 1 });

  // Películas por estrenar
  Future<List<Movie>> getUncoming({ int page = 1 });
  
  // Películas top
  Future<List<Movie>> getTopRated({ int page = 1 });
}
