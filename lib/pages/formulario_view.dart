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
              Navigator.pushNamed(context, 'ficha');
            }
          } else {
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
          : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            children: state.lstAnimal
                .map((e) => InkWell(
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
                    ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_circle_outline_rounded, size: 40,),
        onPressed: () {
        context.read<AnimalBloc>().add(const OnNuevoAnimal());
      }),
    );
  }
}
