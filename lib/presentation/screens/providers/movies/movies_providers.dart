
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/screens/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//? Proveedor de estado que notifica el cambio 
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {


  // referencia al repositorio
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying; // extrayendo función

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
  MovieCallback fetchMoreMovies;
  
  MoviesNotifier({
    required this.fetchMoreMovies,
  }):super([]);

  Future<void> loadNexPage() async {
    // pasando otra página
    currentPage++;

    // nuevo estado de cada cambio 
    final List<Movie> movies = await fetchMoreMovies( page: currentPage );
    // agregando las películas al state    
    state = [...state, ...movies];
  }


}