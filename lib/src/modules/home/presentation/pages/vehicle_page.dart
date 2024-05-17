import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_vehicle_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/vehicle_widgets/vehicle_card.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(builder: (context, state) {
      if (state is VehicleLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is VehiclesLoaded) {
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<VehicleBloc>(context)
                .add(const OnVehiclePageChanged(pageNumber: 1));
          },
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildVehicleListView(state.result.results)),
        );
      }
      return Container();
    });
  }

  Widget _buildVehicleListView(List<VehicleEntity> vehicles) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          VehicleEntity vehicle = vehicles[index];
          return GestureDetector(
            onTap: () {
              context.push(CurrentVehiclePage.routePath, extra: vehicle);
            },
            child: VehicleCard(vehicle: vehicle),
          );
        });
  }
}
