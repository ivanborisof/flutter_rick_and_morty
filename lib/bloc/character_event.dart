import 'package:equatable/equatable.dart';
import 'package:flutter_rick_and_morty/data/models/character.dart';
import 'package:flutter_rick_and_morty/data/repositories/character_repo.dart';

abstract class CharacterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchData extends CharacterEvent {
  final int? pageId;
  final List<Charter>? pastCharacters;
  final String? name;
  FetchData({this.pageId, this.pastCharacters, this.name});
}
