import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_app/src/core/widgets/styles/custom_text_styles.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/vehicle_widgets/vehicle_card.dart';

class RelatedVehicleContainer extends StatelessWidget {
  const RelatedVehicleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vehicles Used/Owned',
          style: openSansBoldText(fontSize: 16),
        ),
        BlocBuilder<VehicleBloc, VehicleState>(builder: (context, state) {
          if (state is VehicleLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }
          if (state is VehicleByIdsLoaded && state.vehicles!.isEmpty) {
            return const Center(
              child: Text('No Vehicles'),
            );
          }
          if (state is VehicleByIdsLoaded && state.vehicles!.isNotEmpty) {
            List<VehicleEntity>? vehicles = state.vehicles;
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: vehicles!.length,
                itemBuilder: ((context, index) {
                  return VehicleCard(vehicle: vehicles[index]);
                }));
          }
          return Container();
        })
      ],
    );
  }
}
