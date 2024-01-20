import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


class MovieHorizontalListview extends StatelessWidget {
  
  final List<Movie> movies;
  // Parámetros opcionales
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;
  
  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subTitle, 
    this.loadNextPage
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          // Títulos - Validando no mostrar si no hay alguno de los 2 
          if ( title != null || subTitle != null )
            _Title( title: title, subTitle: subTitle ),

            // Scroll de películas
            Expanded(
              child: ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _Slide(movie: movies[index]);
                }
              )
            )
        ],
      ),
    );
  }
}



class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({ required this.movie });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}







class _Title extends StatelessWidget {

  final String? title;
  final String? subTitle;

  const _Title({
    this.title, 
    this.subTitle
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of( context ).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only( top: 10 ),
      margin: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Row(
        children: [

          // Título - En cines
          if ( title != null )
            Text(title!, style: titleStyle),

            const Spacer(),

          // Título con botón
          if ( subTitle != null )
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subTitle!)
            )
        ],
      ),
    );
  }
}