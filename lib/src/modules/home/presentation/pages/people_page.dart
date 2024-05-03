import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/film_widgets/film_container.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/people_widgets/people_list.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});
  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<PersonBloc>(context)
            .add(const OnPeoplePageChanged(pageNumber: 1));
      },
      child: const SingleChildScrollView(
        child: Column(
          children: [
            FilmContainer(),
            PeopleList(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
