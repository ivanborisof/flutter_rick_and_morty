import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/data/models/character.dart';

abstract class CharacterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Loading extends CharacterState {}

class Loaded extends CharacterState {
  final List<Charter> arrayOfCharacters;

  Loaded({required this.arrayOfCharacters});
}

class SearchLoaded extends CharacterState {
  final List<Charter> arrayOfCharacters;

  SearchLoaded({required this.arrayOfCharacters});
}

class Error extends CharacterState {}
