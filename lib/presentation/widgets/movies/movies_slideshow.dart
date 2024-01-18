import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      width: double.infinity, // toma todo el ancho

      // Widget de las cards swipe lateral
      child: Swiper(
        viewportFraction: 0.8, // para ver una parte de la carta anterior y la siguiente
        scale: 0.85, // separación
        autoplay: true, // activa movimiento automático  
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
    return const Placeholder();
  }
}

