// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';

import 'package:star_wars_app/src/modules/home/domain/entities/starship_entity.dart';

class StarshipCard extends StatelessWidget {
  final StarshipEntity starship;
  const StarshipCard({
    super.key,
    required this.starship,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: starship.imageUrl == null
                    ? Image.asset('assets/images/no_image.jpg')
                    : Image.network(starship.imageUrl!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          starship.starshipClass,
                          style: openSansMedium(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          starship.model,
                          style:
                              openSansRegular(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          starship.name,
                          style: openSansBoldText(fontSize: 20),
                        ),
                      ),
                    ]),
              ),
            ],
          )),
    );
  }
}
