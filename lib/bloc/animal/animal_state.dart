part of 'animal_bloc.dart';

class AnimalState extends Equatable {
  final bool isWorking;
  final String accion;
  final String campoError;
  final String description;
  final String error;
  final String idAnimal;
  final String msjStatus;

  const AnimalState(
    {
      this.isWorking = false,
      this.accion = '',
      this.campoError = '',
      this.description = '',
      this.error = '',
      this.idAnimal = '',
      this.msjStatus = '',
    });
    
AnimalState copyWith(
  {
  bool? isWorking,
  String? accion,
  String? campoError,
  String? description,
  String? error,
  String? idAnimal,
  String? msjStatus,
  }) => AnimalState(
      isWorking: isWorking ?? this.isWorking,
      accion: accion ?? this.accion,
      campoError: campoError ?? this.campoError,
      description: description ?? this.description,
      error: error ?? this.error,
      idAnimal: idAnimal ?? this.idAnimal,
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
    msjStatus
  ];
  

  
}
