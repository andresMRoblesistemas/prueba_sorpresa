import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_sorpresa/bloc/animal/animal_bloc.dart';
import 'package:prueba_sorpresa/model/animal_model.dart';

class FichaFormularioView extends StatefulWidget {
  const FichaFormularioView({Key? key}) : super(key: key);

  @override
  State<FichaFormularioView> createState() => _FichaFormularioViewState();
}

class _FichaFormularioViewState extends State<FichaFormularioView> {
  late AnimalModel animalModel;
  Map<String, dynamic> datos = {};
  int indice = 1;
  @override
  void initState() {
    animalModel = context.read<AnimalBloc>().state.animal;
    datos = animalModel.toJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 250,
        child: SingleChildScrollView(
          child: BlocConsumer<AnimalBloc, AnimalState>(
            listenWhen: (previous, current) => !current.isWorking,
            listener: (context, state) {
              if (state.error.isEmpty) {
                if (state.accion == "OnValidarAnimal") {
                  context.read<AnimalBloc>().add(const OnGuardarAnimal());
                }
                if (state.accion == "OnGuardarAnimal") {
                  Navigator.pushNamed(context, 'vista');
                  print('guardado');
                }
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  ...datos
                      .entries
                      .map((item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: _ItemFormulario(
                              titulo: item.key,
                              valor: item.value,
                              onChanged: (value) {
                                animalModel = animalModel.copyWith(description: value);
                              },
                            ),
                          )),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'vista');
                          },
                          child: const Text('Cancelar')),
                      const SizedBox(width: 15),
                      ElevatedButton(
                          onPressed: () {
                            print(datos);
                            context.read<AnimalBloc>().add(OnValidarAnimal(
                                animal: animalModel, pagina: 0));
                          },
                          child: const Text('Guardar')),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ItemFormulario extends StatelessWidget {
  const _ItemFormulario({
    Key? key,
    required this.titulo,
    required this.valor,
    required this.onChanged,
  }) : super(key: key);
  final String titulo;
  final String valor;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(titulo),
        TextFormField(
          maxLength: 100,
          controller: TextEditingController(text: valor),
          onChanged: (value) {
            onChanged.call(value);
          },
        )
      ],
    );
  }
}
