import 'package:flutter/material.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';

class VehicleCard extends StatelessWidget {
  final VehicleEntity vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          vehicle.vehicleClass!,
                          style: openSansMedium(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          vehicle.model,
                          style:
                              openSansRegular(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          vehicle.name,
                          style: openSansBoldText(fontSize: 20),
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                width: 88,
                height: 88,
                child: vehicle.imageUrl == null
                    ? Image.asset('assets/images/no_image.jpg')
                    : Image.network(vehicle.imageUrl!),
              )
            ],
          )),
    );
  }
}
