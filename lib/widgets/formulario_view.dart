import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_sorpresa/bloc/animal/animal_bloc.dart';


class FormularioView extends StatelessWidget {
  const FormularioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado'),
      ),
      body: BlocConsumer<AnimalBloc, AnimalState>(
        listenWhen: (previous, current) => !current.isWorking,
        listener: (context, state) {
          if (state.error.isEmpty) {
            if (state.accion == "OnNuevoAnimal") {
              
            }
          } else {
          }
        },
        builder: (context, state) {
          return (state.lstAnimal.isEmpty)
          ? TextFormField(
            initialValue: 'Animal nuevo',
            onChanged: (value) {
            },
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
                            '${e.id} ${e.description}'),
                      ),
                    ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<AnimalBloc>().add(const OnNuevoAnimal());
      }),
    );
  }
}
