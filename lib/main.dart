import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_sorpresa/bloc/animal/animal_bloc.dart';
import 'package:prueba_sorpresa/widgets/formulario_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnimalBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animales App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'formulario': (context) => const FormularioView(),
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