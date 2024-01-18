import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/presentation/screens/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView(),
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    
  // watch - pendiente del estado, obteniendo el estado del provider
  final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );


  if ( nowPlayingMovies.length == 0 ) return CircularProgressIndicator();


    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index){
        final movie  = nowPlayingMovies[index];

        return ListTile(
          title: Text( movie.title ),
        );

    });
  }
}