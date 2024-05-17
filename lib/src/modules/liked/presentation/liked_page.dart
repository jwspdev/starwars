import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/dependency_injection/injection_container.dart';
import 'package:star_wars_app/src/modules/liked/presentation/people/bloc/local_people_bloc.dart';
import 'package:star_wars_app/src/modules/liked/presentation/people/pages/local_people_page.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider<LocalPeopleBloc>(
            create: (context) => sl()..add(const OnGetLocalPeople())),
      ], child: const LocalPeoplePage()),
    );
  }
}
