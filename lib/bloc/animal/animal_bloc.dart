import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_sorpresa/model/animal_model.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  
  AnimalBloc() : super( AnimalState()) {
    on<OnOrdenaAnimal>(_onOrdenaAnimal);
    on<OnEliminaAnimal>(_onEliminaAnimal);
    on<OnNuevoAnimal>(_onNuevoAnimal);
    on<OnModificarAnimal>(_onModificarAnimal);
    on<OnValidarAnimal>(_onValidarAnimal);
    on<OnGuardarAnimal>(_onGuardarAnimal);
    on<OnObtieneAnimal>(_onObtieneAnimal);
  }

  Future<void> _onGuardarAnimal(OnGuardarAnimal event, Emitter emit) async {
    try {
      emit(state.copyWith(
          isWorking: true,
          error: '',
          msjStatus: '',
          accion: "OnGuardarAnimal"));
      String error = '';
      String msjStatus = '';
      error = '';
      AnimalModel animal = state.animal;
      List<AnimalModel> lstAnimal = [...state.lstAnimal];
      if (error.isEmpty) {
        if (animal.id.isEmpty) {
          animal = animal.copyWith(id: (lstAnimal.length + 1).toString());
          lstAnimal.add(animal);
        } else {
          lstAnimal = lstAnimal.map((e) {
            if (e.id == animal.id) {
              return animal;
            } else {
              return e;
            }
          }).toList();
        }
      }

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: msjStatus,
          lstAnimal: lstAnimal,
          animal: (error.isEmpty) ? animal : null,
          accion: "OnGuardarAnimal"));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: "OnGuardarAnimal"));
    }
  }

  Future<void> _onValidarAnimal(OnValidarAnimal event, Emitter emit) async {
    try {
      emit(state.copyWith(
          isWorking: true,
          error: '',
          accion: "OnValidarAnimal"));

      final validacion = await validaAnimal(event.animal, event.pagina);

      emit(state.copyWith(
          isWorking: false,
          error: validacion['error'],
          msjStatus: '',
          campoError: validacion['campoError'],
          animal: validacion['animal'],
          accion: "OnValidarAnimal"));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: "OnValidarAnimal"));
    }
  }

  Future<Map<String, dynamic>> validaAnimal(
      AnimalModel animal, int pagina) async {
    try {
      String error = '', campoError = '';

      AnimalModel newAnimal = state.animal;

      if (pagina == 0 || pagina >= 1) {
        if (animal.description.isEmpty) {
          error = 'Falta Definir el Nombre';
          campoError = 'Description';
        } else {
          newAnimal =
              newAnimal.copyWith(description: animal.description);
        }
      }
      return {'error': error, 'campoError': campoError, 'animal': newAnimal};
    } catch (e) {
      return {
        'error': e.toString(),
        'campoError': 'wop',
        'animal': const AnimalModel()
      };
    }
  }



  Future<void> _onModificarAnimal(
      OnModificarAnimal event, Emitter emit) async {
    try {
      String error = '';
      AnimalModel animal = const AnimalModel();
      emit(state.copyWith(
          isWorking: true,
          error: '',
          accion: "OnModificarAnimal"));
      animal =
          state.lstAnimal.firstWhere((item) => item.id == event.idAnimal);

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: '',
          animal: animal,
          accion: "OnModificarAnimal"));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: "OnModificarAnimal"));
    }
  }

  Future<void> _onNuevoAnimal(OnNuevoAnimal event, Emitter emit) async {
    emit(state.copyWith(
        animal: const AnimalModel(),
        error: '',
        accion: "OnNuevoAnimal"));
  }

  Future<void> _onEliminaAnimal(
      OnEliminaAnimal event, Emitter emit) async {

  }

  Future<void> _onOrdenaAnimal(
      OnOrdenaAnimal event, Emitter emit) async {

  }

  Future<void> _onObtieneAnimal(
      OnObtieneAnimal event, Emitter emit) async {
    try {
      emit(state.copyWith(
          isWorking: true,
          error: '',
          animal: const AnimalModel(),
          lstAnimal: [],
          accion: "OnObtieneAnimal"));

      String error = '';

      const List<AnimalModel> lstAnimal = [
        AnimalModel(
            id: '1',
            description: "Halcon",),
        AnimalModel(
            id: '2',
            description: "Gato",),
        AnimalModel(
            id: '3',
            description: "Pulpo")
      ];

      emit(state.copyWith(
          isWorking: false,
          error: error,
          lstAnimal: (error.isEmpty) ? lstAnimal : null,
          accion: "OnObtieneAnimal"));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          accion: "OnObtieneAnimal"
        )
      );
    }
  }

}
