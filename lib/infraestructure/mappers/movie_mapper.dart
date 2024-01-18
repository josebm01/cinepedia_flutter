

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infraestructure/models/moviedb/movie_moviedb.dart';

//? Toma la implementación de MovieMovieDB y transformarlo a la entidad
class MovieMapper {
  static Movie movieDBToEntity( MovieMovieDB moviedb ) => Movie(
    adult: moviedb.adult,
    backdropPath: moviedb.backdropPath != '' 
      ? 'https://image.tmdb.org/t/p/w500/${ moviedb.backdropPath }.jpg'
      : 'https://www.initcoms.com/wp-content/uploads/2020/07/404-error-not-found-1.png',
    genreIds: moviedb.genreIds.map( (e) => e.toString()).toList(), // transformando enteros a string y en lista
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: moviedb.posterPath != ''
      ? 'https://image.tmdb.org/t/p/w500/${ moviedb.posterPath }.jpg'
      : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );
}