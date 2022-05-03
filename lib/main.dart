import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/character_block.dart';
import 'package:flutter_rick_and_morty/bloc/character_event.dart';
import 'package:flutter_rick_and_morty/bloc/character_state.dart';
import 'package:flutter_rick_and_morty/ui/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CharacterBlock(Loading())..add(FetchData())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: ThemeData.light().textTheme.copyWith(),
          fontFamily: "Rubik",
        ),
        home: const MainPage(),
      ),
    );
  }
}
