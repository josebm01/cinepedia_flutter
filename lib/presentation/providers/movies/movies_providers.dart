
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//? Proveedor de estado que notifica el cambio 
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // referencia al repositorio
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying; // extrayendo referencia de la función

  // regresa una instancia
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


//? Creando diferentes instancias de la misma clase
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // referencia al repositorio
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular; // extrayendo referencia de la función

  // regresa una instancia
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final uncomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // referencia al repositorio
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUncoming; // extrayendo referencia de la función

  // regresa una instancia
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});


final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // referencia al repositorio
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated; // extrayendo referencia de la función

  // regresa una instancia
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});





//? tipo de función que se espera
typedef MovieCallback = Future<List<Movie>> Function({ int page });


//? Consultando provider cuando suceda un cambio 
class MoviesNotifier extends StateNotifier<List<Movie>> {
  
  int currentPage = 0; // página actual
  bool isLoading = false; // bandera controlar peticiones simultáneas
  MovieCallback fetchMoreMovies;
  
  MoviesNotifier({
    required this.fetchMoreMovies,
  }):super([]);

  Future<void> loadNexPage() async {
    // para no hacer más peticiones
    if ( isLoading ) return;

    isLoading = true;  

    // pasando otra página
    currentPage++;
    // nuevo estado de cada cambio 
    final List<Movie> movies = await fetchMoreMovies( page: currentPage );
    // agregando las películas al state    
    state = [...state, ...movies];
    // renderizar películas más controlado
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;  
  }


}