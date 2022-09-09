part of 'animal_bloc.dart';

class AnimalState extends Equatable {
  final bool isWorking;
  final String accion;
  final String campoError;
  final String description;
  final String error;
  final String idAnimal;
  final AnimalModel animal;
  final List<AnimalModel> lstAnimal;
  final String msjStatus;

  AnimalState(
    {
      this.isWorking = false,
      this.accion = '',
      this.campoError = '',
      this.description = '',
      this.error = '',
      this.idAnimal = '',
      AnimalModel? animal,
      List<AnimalModel>? lstAnimal,
      this.msjStatus = '',
    }): animal = animal ?? const AnimalModel(),
    lstAnimal = lstAnimal ?? [];
    
AnimalState copyWith(
  {
  bool? isWorking,
  String? accion,
  String? campoError,
  String? description,
  String? error,
  String? idAnimal,
  AnimalModel? animal,
  List<AnimalModel>? lstAnimal,
  String? msjStatus,
  }) => AnimalState(
      isWorking: isWorking ?? this.isWorking,
      accion: accion ?? this.accion,
      campoError: campoError ?? this.campoError,
      description: description ?? this.description,
      error: error ?? this.error,
      idAnimal: idAnimal ?? this.idAnimal,
      animal: animal ?? this.animal,
      lstAnimal: lstAnimal ?? this.lstAnimal,
      msjStatus: msjStatus ?? this.msjStatus,
    );

  @override
  List<Object?> get props => [
    isWorking,
    accion,
    campoError,
    description,
    error,
    idAnimal,
    animal,
    lstAnimal,
    msjStatus
  ];
  

  
}
