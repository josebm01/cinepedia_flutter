import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  
  //? Instancia para crear la petición  
  // Configuraciones para las peticiones
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDBKey,
      'language': 'es-MX'
    }
  ));
  
  
  //? Obtener películas
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get('/movie/now_playing');

    //? Recibiendo el json
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    //? Devolver información en un listado en base a la entidad
    final List<Movie> movies = movieDBResponse.results
    .where( (moviedb) => moviedb.posterPath != 'no-poster' ) //? filtrando que traiga poster y no la muestra
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();    

    return movies;
  }

}