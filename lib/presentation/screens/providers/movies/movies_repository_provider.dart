//! Creando instancia del repositorio
// Providers de solo lectura porque no va a cambiar - solo provee información
import 'package:cinemapedia/infraestructure/datasources/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infraestructure/repositories/movie_repository_imp.dart';

//? Repositorio de solo lectura, es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRespositoryImp( MoviedbDatasource() );
});