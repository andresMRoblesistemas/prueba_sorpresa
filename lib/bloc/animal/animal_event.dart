part of 'animal_bloc.dart';

abstract class AnimalEvent extends Equatable{
  const AnimalEvent();

  @override
  List<Object> get props => [];
}

class OnObtieneAnimales extends AnimalEvent { //no lo pidieron pero es necesario para trabajar 🤷
  const OnObtieneAnimales();
}

class OnNuevaAnimal extends AnimalEvent {
  const OnNuevaAnimal();
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
  const OnValidarAnimal({required this.animal});
}

class OnGuardarAnimal extends AnimalEvent {
  const OnGuardarAnimal();
}
