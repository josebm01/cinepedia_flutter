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
  


  //! simplificando lo que se procesa en la petición
  List<Movie> _jsonToMovies( Map<String, dynamic> json ) {

    //? Recibiendo el json
    final movieDBResponse = MovieDbResponse.fromJson(json);
    
    //? Devolver información en un listado en base a la entidad
    final List<Movie> movies = movieDBResponse.results
    .where( (moviedb) => moviedb.posterPath != 'no-poster' ) //? filtrando que traiga poster y no la muestra
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();    

    return movies;
    
  }

  
  //? Obtener películas
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing',
      queryParameters: {
      "page": page
      } 
    );
    return _jsonToMovies(response.data);
  }
  
 //? Películas populares
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular',
      queryParameters: {
      "page": page
      } 
    );
    return _jsonToMovies(response.data);
  }

 //? Películas por estrenar
  @override
  Future<List<Movie>> getUncoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
      queryParameters: {
      "page": page
      } 
    );
    return _jsonToMovies(response.data);
  }

 //? Películas top
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
      queryParameters: {
      "page": page
      } 
    );
    return _jsonToMovies(response.data);
  }



}