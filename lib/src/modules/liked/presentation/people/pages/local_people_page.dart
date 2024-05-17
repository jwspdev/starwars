import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_person_page.dart';
import 'package:star_wars_app/src/modules/liked/presentation/people/bloc/local_people_bloc.dart';

class LocalPeoplePage extends StatefulWidget {
  const LocalPeoplePage({super.key});

  @override
  State<LocalPeoplePage> createState() => _LocalPeoplePageState();
}

class _LocalPeoplePageState extends State<LocalPeoplePage> {
  @override
  void initState() {
    super.initState();
    debugPrint('INITIALIZED');
  }

  @override
  void dispose() {
    debugPrint('DISPOSED');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalPeopleBloc, LocalPeopleState>(
        listener: (context, state) {
      if (state is IsPersonDisliked || state is IsPersonLiked) {
        context.read<LocalPeopleBloc>().add(const OnGetLocalPeople());
      }
    }, builder: (context, state) {
      if (state is LocalPeopleLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is LocalPeopleLoaded) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemCount: state.peopleList.length,
            itemBuilder: (context, index) {
              var currentPerson = state.peopleList[index];
              return GestureDetector(
                onTap: () async {
                  String? isDislikedString = await context.pushNamed(
                      CurrentPersonPage.routePath,
                      extra: currentPerson);
                  if (isDislikedString != null &&
                      isDislikedString == 'disliked') {
                    setState(() {
                      context
                          .read<LocalPeopleBloc>()
                          .add(const OnGetLocalPeople());
                    });
                  }
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
            });
      }
      return Container();
    });
  }
}
