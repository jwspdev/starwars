// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';

class RelatedPeopleContainer extends StatelessWidget {
  final bool isTransportation;
  const RelatedPeopleContainer({
    super.key,
    required this.isTransportation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTransportation ? 'Pilots' : 'Characters',
          style: openSansBoldText(fontSize: 16),
        ),
        BlocBuilder<PersonBloc, PersonState>(builder: (context, state) {
          if (state is PersonLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is PeopleByIdsLoaded && state.peopleList.isEmpty) {
            return const Center(
              child: Text('no piolts'),
            );
          }
          if (state is PeopleByIdsLoaded && state.peopleList.isNotEmpty) {
            List<PersonEntity>? peopleList = state.peopleList;
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: peopleList.length,
                itemBuilder: (context, index) {
                  var currentPerson = peopleList[index];
                  return Card(
                    child: Row(children: [
                      CircleAvatar(
                        child: currentPerson.imageUrl == null
                            ? Image.asset('assets/images/no_image.jpg')
                            : Image.network(currentPerson.imageUrl!),
                      ),
                      Column(
                        children: [Text(currentPerson.name)],
                      )
                    ]),
                  );
                });
          }
          return Container(
            color: Colors.amber,
          );
        })
      ],
    );
  }
}
