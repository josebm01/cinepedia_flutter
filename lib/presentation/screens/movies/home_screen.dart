import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      // Barra de navegación  
      bottomNavigationBar: CustomBottomNavigation(),      
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

//? Consumer para tener acceso global al ref
class _HomeViewState extends ConsumerState<_HomeView> {
  
  @override
  void initState() {
    super.initState();

    // llamando función de la petición, no obteniendo el estado
    ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
    ref.read(popularMoviesProvider.notifier).loadNexPage();
    ref.read(uncomingMoviesProvider.notifier).loadNexPage();
    ref.read(topRatedMoviesProvider.notifier).loadNexPage();
  }

  @override
  Widget build(BuildContext context) {
    

    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();


    // Utilizando nuevo provider para limitar cantidad de paginado
    final slideShowMovies = ref.watch( moviesSlideshowProvider );

    // watch - pendiente del estado, obteniendo el estado del provider
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final uncomingMovies = ref.watch( uncomingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );

  
  
    //! Envolviendo en un widget para poder hacer scroll
    return CustomScrollView(
      //? widget que trabaja específicamente con el scrollview
      slivers: [

        // widget para mantener flotando la barra
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),

        // delete es donde estarán los widgteds dentro del scrollview
        SliverList(delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
          children: [
              MoviesSlideshow(movies: slideShowMovies),
        
              MovieHorizontalListview( 
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Lunes 20', 
                loadNextPage: (){
                  //? read - solo dentro de funciones
                  ref.read(nowPlayingMoviesProvider.notifier).loadNexPage();
                },
              ),
        
              MovieHorizontalListview( 
                movies: uncomingMovies,
                title: 'Próximamente',
                subTitle: 'En este mes', 
                loadNextPage: (){
                  //? read - solo dentro de funciones
                  ref.read(uncomingMoviesProvider.notifier).loadNexPage();
                },
              ),
              
              MovieHorizontalListview( 
                movies: popularMovies,
                title: 'Populares',
                // subTitle: 'En ', 
                loadNextPage: (){
                  //? read - solo dentro de funciones
                  ref.read(popularMoviesProvider.notifier).loadNexPage();
                },
              ),
        
              MovieHorizontalListview( 
                movies: topRatedMovies,
                title: 'Mejor calificadas',
                subTitle: 'Desde siempre', 
                loadNextPage: (){
                  //? read - solo dentro de funciones
                  ref.read(topRatedMoviesProvider.notifier).loadNexPage();
                },
              ),

              const SizedBox( height: 40 )
            ],
          );
        },  
        childCount: 1  
        ))
      ]
    );
  }
}