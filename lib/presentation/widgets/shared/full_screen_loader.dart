import 'package:flutter/material.dart';


class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {

    final messages = <String>[
      'Cargando películas',
      'Comprando palomitas de maíz',
      'Ya merito',
      'Esto está tardando más de lo esperado :(',
      'Se estén terminando de cocinar las palomitas',
    ];

    return Stream.periodic( const Duration( milliseconds: 1200 ), (step) {
      return messages[step];
    }).take( messages.length );
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 5),
          const SizedBox(height: 10),

          // Construye en base a un string
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if ( !snapshot.hasData ) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )

        ],
      ),
    );
  }
}