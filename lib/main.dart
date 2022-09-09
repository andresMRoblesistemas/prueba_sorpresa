import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_sorpresa/bloc/animal/animal_bloc.dart';
import 'package:prueba_sorpresa/pages/ficha_formulario_view.dart';
import 'package:prueba_sorpresa/pages/formulario_view.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

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
        initialRoute: 'vista',
        builder: (context, child) {
          return Scaffold(
            body: Builder(builder: (context) {
              context.read<AnimalBloc>().add(const OnObtieneAnimal());
              return ResponsiveWrapper.builder(
                  maxWidth: 1200,
                  minWidth: 250,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.autoScale(260, name: PHONE),
                    const ResponsiveBreakpoint.autoScale(500, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(780, name: TABLET),
                    const ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
                    // const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
                  ],
                  child);
            },)
          );
        }
      ),
    );
  }
}