import 'dart:convert';

import 'package:equatable/equatable.dart';

AnimalModel animalModelFromJson(String str) =>
    AnimalModel.fromJson(json.decode(str));

String animalModelToJson(AnimalModel data) =>
    json.encode(data.toJson());

class AnimalModel extends Equatable {
  const AnimalModel(
      {this.id = '',
      this.description= '',
      });

  final String description;
  final String id;

  AnimalModel copyWith(
      {String? id,
      String? description}) {
    return AnimalModel(
      id: id ?? this.id,
      description: description ?? this.description
    );
  }

  factory AnimalModel.fromJson(Map<String, dynamic> json) =>
      AnimalModel(
        id: (json.containsKey("id")) ? json["id"].toString() : '',
        description: (json.containsKey("description")) ? json["description"].toString() : '',
      );

  
  Map<String, dynamic> toJson() => {
        "Animal nuevo: ": description,
      };

  @override
  List<Object?> get props => [
        id,
        description
      ];

}
