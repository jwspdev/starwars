import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_person_page.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonBloc, PersonState>(builder: (context, state) {
      // return Text('${state}');
      if (state is PersonLoading) {
        return const CupertinoActivityIndicator();
      }
      if (state is ListOfPeopleLoaded) {
        List<PersonEntity> personList = state.result.results;
        return _buildGridView(personList);
      }
      if (state is PersonError) {
        return Text('Error: ${state.exception}');
      }

      return const Text('default');
    });
  }

  _buildGridView(List<PersonEntity> personList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
          primary: false,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemCount: personList.length,
          itemBuilder: (context, index) {
            var currentPerson = personList[index];
            return GestureDetector(
              onTap: () {
                context.push(CurrentPersonPage.routePath, extra: currentPerson);
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.grey,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: currentPerson.imageUrl == null
                          ? Image.asset(
                              'assets/images/no_image.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            )
                          : Image.network('${currentPerson.imageUrl}'),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        currentPerson.name,
                        style: openSansMedium(color: Colors.white)
                            .merge(customOutlinedTextStyle()),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
