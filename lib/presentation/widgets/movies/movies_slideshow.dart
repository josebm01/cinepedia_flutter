import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';


class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity, // toma todo el ancho

      // Widget de las cards swipe lateral
      child: Swiper(
        viewportFraction: 0.8, // para ver una parte de la carta anterior y la siguiente
        scale: 0.85, // separación
        autoplay: true, // activa movimiento automático  
        // paginación
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary, // color de puntero actual en la número en el que se encuenta
            color: colors.secondary  // color de todas las páginas
          )
        ), 
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slice(movie: movies[index])
      ),
    );
  }
}



class _Slice extends StatelessWidget {

  final Movie movie;
  const _Slice({required this.movie});

  @override
  Widget build(BuildContext context) {

    // configuración del widget para el sombreado 
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, -10),
        )
      ]
    ); 

    return Padding(
      padding: const EdgeInsets.only( bottom: 30 ),
      child: DecoratedBox(
        decoration: decoration,
        // border redondeados
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.posterPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if ( loadingProgress != null ) {
                return const DecoratedBox(
                  decoration: BoxDecoration( color: Colors.black12 )
                );
              }
              // return child;
              return FadeIn(child: child);
            },
          ),
        // child: Placeholder(),
        )
      ),
    );
  }
}

