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
                ///Si no existe errores
                if (state.accion == "OnValidarAnimal") {
                  context.read<AnimalBloc>().add(const OnGuardarAnimal());
                }
                if (state.accion == "OnGuardarAnimal") {
                  Navigator.of(context).pop();
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
                            child: Row(
                              children: [
                                Text(state.animal.description),
                                TextFormField(
                                  initialValue: (state.animal.description),
                                  onChanged: (value) {
                                    datos['description'] = value;
                                  },
                                )
                              ],
                            )
                            // Text(
                            //   titulo: item.key,
                            //   valor: item.value,
                            //   onChanged: (value) {
                            //     datos[item.key] = value;
                            //   },
                            // ),
                          )),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              try {
                                datos.putIfAbsent(' $indice', () => '');
                                indice++;
                              } catch (e) {
                                print('error $e');
                              }
                            });
                          },
                          child: const Text('Cancelar')),
                      const SizedBox(width: 15),
                      ElevatedButton(
                          onPressed: () {
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