import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_sorpresa/bloc/animal/animal_bloc.dart';
import 'package:prueba_sorpresa/pages/ficha_formulario_view.dart';
import 'package:prueba_sorpresa/pages/formulario_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnimalBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animales App',
        routes: {
          'vista': (context) => const FormularioView(),
          'ficha': (context) => const FichaFormularioView(),
        },
        initialRoute: 'formulario',
        builder: (context, child) {
          return Scaffold(
            body: Builder(builder: (context) {
              context.read<AnimalBloc>().add(const OnObtieneAnimal());
              return const FormularioView();
            },)
          );
        }
      ),
    );
  }
}