import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/character_event.dart';
import 'package:flutter_rick_and_morty/bloc/character_state.dart';
import 'package:flutter_rick_and_morty/data/models/character.dart';
import 'package:flutter_rick_and_morty/data/repositories/character_repo.dart';

class CharacterBlock extends Bloc<CharacterEvent, CharacterState> {
  CharacterBlock(CharacterState initialState) : super(initialState) {
    on<FetchData>((event, emit) async {
      emit(Loading());

      List<Charter> characters = [];

      if (event.name != null) {
        characters = await CharterRepo().getChartersByName(event.name!);
        characters.isEmpty
            ? emit(Error())
            : emit(SearchLoaded(arrayOfCharacters: characters));
      } else {
        characters = await CharterRepo().getChartersByPage(event.pageId ?? 1);
        characters.isEmpty
            ? emit(Error())
            : emit(Loaded(arrayOfCharacters: characters));
      }

      // if (characters.isEmpty) {
      //   emit(Error());
      // } else {
      //   emit(Loaded(arrayOfCharacters: characters));
      // }
    });
  }
}
