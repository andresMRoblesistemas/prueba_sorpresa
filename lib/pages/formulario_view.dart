import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prueba_sorpresa/bloc/animal/animal_bloc.dart';


class FormularioView extends StatelessWidget {
  const FormularioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista'),
      ),
      body: BlocConsumer<AnimalBloc, AnimalState>(
        listenWhen: (previous, current) => !current.isWorking,
        listener: (context, state) {
          if (state.error.isEmpty) {
            if (state.accion == "OnNuevoAnimal" || state.accion == "OnModificarAnimal") {
              Navigator.pushReplacementNamed(context, 'ficha');
            }
          } else if (state.accion == "OnEliminaAnimal" || state.accion == "OnOrdenaAnimal"){
            context.read<AnimalBloc>().add(const OnObtieneAnimal());
          } 
        },
        builder: (context, state) {
          return (state.lstAnimal.isEmpty)
          ? Center(
            child: Padding(
              padding: const  EdgeInsets.symmetric(vertical: 100),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/dog-png.webp')),
                  const Text('Aun no hay nada por aqui'),
                ],
              ),
            ),
          )
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 500,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    children: state.lstAnimal
                        .map((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<AnimalBloc>()
                                    .add(OnModificarAnimal(idAnimal: e.id));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    e.description),
                              ),
                            ),
                            InkWell(
                              child: Icon(Icons.delete, color: Colors.red.shade400,),
                              onTap: () {
                                context
                                    .read<AnimalBloc>()
                                    .add(OnEliminaAnimal(description: e.description));
                              },
                            )
                          ],
                        )
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            mini: true,
            child: const Icon(Icons.sort_by_alpha, size: 30,),
            onPressed: () {
            context.read<AnimalBloc>().add(const OnOrdenaAnimal());
          }),
          const SizedBox(width: 20,),
          FloatingActionButton(
            mini: true,
            child: const Icon(Icons.add_circle_outline_rounded, size: 30,),
            onPressed: () {
            context.read<AnimalBloc>().add(const OnNuevoAnimal());
          }),
          
        ],
      ),
    );
  }
}
