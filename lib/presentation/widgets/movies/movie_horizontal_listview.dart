import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';


class MovieHorizontalListview extends StatefulWidget {
  
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
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}



//! Estado para cargar más películas
class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();


    scrollController.addListener(() {
      // verificando si se está dando scroll para mostrar más películas
      if ( widget.loadNextPage == null ) return;

      // El momento de llamar la función para cargar más películas cuando sobre pase el tamaño máximo del scroll
      if ( scrollController.position.pixels  + 200 >= scrollController.position.maxScrollExtent ) {
        // llamando función
        widget.loadNextPage!();
      }
    });

  }

  //? limpiar state
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          // Títulos - Validando no mostrar si no hay alguno de los 2 
          if ( widget.title != null || widget.subTitle != null )
            _Title( title: widget.title, subTitle: widget.subTitle ),

            // Scroll de películas
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.movies.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FadeInRight(child: _Slide(movie: widget.movies[index]));
                }
              )
            )
        ],
      ),
    );
  }
}


//! Carta de las películas en cines
class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({ required this.movie });

  @override
  Widget build(BuildContext context) {
    
    // estilo del texto
    final textStyles = Theme.of(context).textTheme;    

    return Container(
      margin: const EdgeInsets.symmetric( horizontal: 8 ),
      child: Column(
        // alinear todos los hijos al inicio
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //! Imagen
          SizedBox(
            width: 150,
            //? Bordes redondeados
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                // Mismo espacio de las imágenes
                fit: BoxFit.cover,
                width: 150,
                // Loading
                loadingBuilder: (context, child, loadingProgress) {
                  
                  // Mostrando spinner mientras se cargan las imágenes de las películas
                  if ( loadingProgress != null ) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2))
                    );
                  }

                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          // separación
          const SizedBox(height: 5),
          
          //! Título
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2, // líneas máximas a mostrar
              style: textStyles.titleSmall,
            ),
          ),

          //! Valoraciones
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon( Icons.star_half_outlined, color: Colors.yellow.shade800),
                // separación
                const SizedBox( width: 3 ),
                // Icono de estrella y cantidad de votos
                Text('${ movie.voteAverage }', style: textStyles.bodyMedium?.copyWith( color: Colors.yellow.shade800 )),
                const SizedBox( width: 10 ),
                const Spacer(),
                // Cantidad de views y formateando la cantidad con la función HumanFormats
                Text( HumanFormats.number( movie.popularity ), style: textStyles.bodySmall,)
              ],
            ),
          )


        ]
      ),
    );
  }
}



//! Títulos
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