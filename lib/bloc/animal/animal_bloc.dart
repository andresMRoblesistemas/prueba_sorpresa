import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_sorpresa/model/animal_model.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  
  AnimalBloc() : super( AnimalState()) {
    on<OnOrdenaAnimal>(_onOrdenaAnimal);
    on<OnEliminaAnimal>(_onEliminaAnimal); //ok
    on<OnNuevoAnimal>(_onNuevoAnimal);  //ok
    on<OnModificarAnimal>(_onModificarAnimal); //ok
    on<OnValidarAnimal>(_onValidarAnimal); //ok
    on<OnGuardarAnimal>(_onGuardarAnimal); //ok
    on<OnObtieneAnimal>(_onObtieneAnimal); //ok
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
        if (animal.description.length < 4) {
          error = 'Por favor escriba un nombre más largo';
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
    try {
      String error = '';
      emit(state.copyWith(
          isWorking: true,
          error: '',
          accion: "OnEliminaAnimal"));
      
      state.lstAnimal.removeWhere((item) => item.description == event.description);

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: '',
          lstAnimal: state.lstAnimal,
          accion: "OnEliminaAnimal"));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: "OnEliminaAnimal"));
    }

  }

  Future<void> _onOrdenaAnimal(
      OnOrdenaAnimal event, Emitter emit) async {
      try {
      String error = '';
      emit(state.copyWith(
          isWorking: true,
          error: '',
          accion: "OnOrdenaAnimal"));
      
      state.lstAnimal.sort((a, b) => a.description .compareTo(b.description));

      emit(state.copyWith(
          isWorking: false,
          error: error,
          msjStatus: '',
          lstAnimal: state.lstAnimal,
          accion: "OnOrdenaAnimal"));
    } catch (e) {
      emit(state.copyWith(
          isWorking: false,
          error: e.toString(),
          accion: "OnOrdenaAnimal"));
    }

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

      const List<AnimalModel> lstAnimal = [];

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
