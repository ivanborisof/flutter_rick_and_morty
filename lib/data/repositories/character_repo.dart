import 'dart:convert';

import 'package:flutter_rick_and_morty/data/models/character.dart';
import 'package:http/http.dart' as http;

class CharterRepo {
  Future<List<Charter>> getChartersByPage(int pageId) async {
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=' +
            pageId.toString()));

    List<Charter> charters = [];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var i in json["results"]) {
        Charter character = Charter.fromJson(i);

        final episodeResponse = await http.get(Uri.parse(i["episode"][0]));

        if (episodeResponse.statusCode == 200) {
          character.firstSeen = jsonDecode(episodeResponse.body)["name"];
        }

        charters.add(character);
      }
    }

    return charters;
  }

  Future<List<Charter>> getChartersByName(String name) async {
    final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?name=' + name));

    List<Charter> charters = [];

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      for (var i in json["results"]) {
        Charter character = Charter.fromJson(i);

        final episodeResponse = await http.get(Uri.parse(i["episode"][0]));

        if (episodeResponse.statusCode == 200) {
          character.firstSeen = jsonDecode(episodeResponse.body)["name"];
        }

        charters.add(character);
      }
    }

    return charters;
  }

  Future<int> getNumberOfPages() async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    return jsonDecode(response.body)["info"]["pages"];
  }
}
