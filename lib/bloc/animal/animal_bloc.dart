import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prueba_sorpresa/model/animal_model.dart';

part 'animal_event.dart';
part 'animal_state.dart';

class AnimalBloc extends Bloc<AnimalEvent, AnimalState> {
  
  AnimalBloc() : super( const AnimalState()) {
    on<OnOrdenaAnimal>(_onOrdenaAnimal);
    on<OnEliminaAnimal>(_onEliminaAnimal);
    on<OnNuevaAnimal>(_onNuevaAnimal);
    on<OnModificarAnimal>(_onModificarAnimal);
    on<OnValidarAnimal>(_onValidarAnimal);
    on<OnGuardarAnimal>(_onGuardarAnimal);
  }

  Future<void> _onGuardarAnimal(
      OnGuardarAnimal event, Emitter emit) async {

  }

  Future<void> _onValidarAnimal(
      OnValidarAnimal event, Emitter emit) async {

  }

  Future<void> _onModificarAnimal(
      OnModificarAnimal event, Emitter emit) async {

  }

  Future<void> _onNuevaAnimal(
      OnNuevaAnimal event, Emitter emit) async {

  }

  Future<void> _onEliminaAnimal(
      OnEliminaAnimal event, Emitter emit) async {

  }

  Future<void> _onOrdenaAnimal(
      OnOrdenaAnimal event, Emitter emit) async {

  }

}
