// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/person_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/person_bloc/person_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_person_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/no_data_widget.dart';

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
          if (state is PeopleByIdsLoaded && state.people.isEmpty) {
            return NoDataWidget(
              icon: Icons.no_accounts,
              message:
                  isTransportation ? 'No Pilots Found' : 'No Characters Found',
            );
          }
          if (state is PeopleByIdsLoaded && state.people.isNotEmpty) {
            List<PersonEntity>? peopleList = state.people;
            return GridView.builder(
                padding: const EdgeInsets.all(4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 8,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: peopleList.length,
                itemBuilder: (context, index) {
                  var currentPerson = peopleList[index];
                  return GestureDetector(
                    onTap: () {
                      context.push(CurrentPersonPage.routePath,
                          extra: currentPerson);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            currentPerson.imageUrl == null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    child: Image.asset(
                                      'assets/images/no_image.jpg',
                                      // fit: BoxFit.fitHeight,
                                    ))
                                : Image.network(currentPerson.imageUrl!),
                            Column(
                              children: [
                                Text(
                                  currentPerson.name,
                                  style: openSansMedium(),
                                )
                              ],
                            )
                          ]),
                    ),
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
