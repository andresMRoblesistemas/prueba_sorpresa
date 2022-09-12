part of 'animal_bloc.dart';

abstract class AnimalEvent extends Equatable{
  const AnimalEvent();

  @override
  List<Object> get props => [];
}

class OnObtieneAnimal extends AnimalEvent {
  const OnObtieneAnimal();
}

class OnNuevoAnimal extends AnimalEvent {
  const OnNuevoAnimal();
}

class OnModificarAnimal extends AnimalEvent {
  final String idAnimal;
  const OnModificarAnimal({required this.idAnimal});
}

class OnEliminaAnimal extends AnimalEvent {
  final String idAnimal;
  const OnEliminaAnimal({required this.idAnimal});
}

class OnOrdenaAnimal extends AnimalEvent {
  const OnOrdenaAnimal();
}

class OnValidarAnimal extends AnimalEvent {
  final AnimalModel animal;
  final int pagina;
  const OnValidarAnimal({required this.animal, required this.pagina});
}

class OnGuardarAnimal extends AnimalEvent {
  const OnGuardarAnimal();
}
