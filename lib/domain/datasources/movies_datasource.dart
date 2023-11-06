import 'package:cinemapedia/domain/entities/movie.dart';

//? abstract, no se crearán instancias de la clase 
abstract class MovieDatasource {

  Future<List<Movie>> getNowPlaying({ int page = 1 });
}
