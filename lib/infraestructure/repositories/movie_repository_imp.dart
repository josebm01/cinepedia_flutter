
//! llama el datasource y el datasource llamará los métodos definidos aquí
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRespositoryImp extends MoviesRepository {

  // Para poder cambiar los orígenes de los datos
  // Llama la clase padre, no la implementación
  final MoviesDatasource datasource;
  MovieRespositoryImp(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

}