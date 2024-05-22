import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_wars_app/src/modules/home/domain/entities/vehicle_entity.dart';
import 'package:star_wars_app/src/modules/home/presentation/blocs/vehicle_bloc/vehicle_bloc.dart';
import 'package:star_wars_app/src/modules/home/presentation/pages/current_pages.dart/current_vehicle_page.dart';
import 'package:star_wars_app/src/modules/home/presentation/widgets/vehicle_widgets/vehicle_card.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    VehicleBloc bloc = context.read<VehicleBloc>();
    return BlocConsumer<VehicleBloc, VehicleState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is VehicleLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is VehiclesLoaded || state is LoadMoreVehicles) {
            final vehicles = state.result;
            return SingleChildScrollView(
              controller: bloc.scrollController,
              child: Column(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<VehicleBloc>(context).page = 1;
                      BlocProvider.of<VehicleBloc>(context)
                          .add(const OnVehiclePageChanged());
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildVehicleListView(vehicles, context, state)),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }

  Widget _buildVehicleListView(
      List<VehicleEntity> vehicles, BuildContext context, VehicleState state) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            state is LoadMoreVehicles ? vehicles.length + 1 : vehicles.length,
        itemBuilder: (context, index) {
          if (index < vehicles.length) {
            VehicleEntity vehicle = vehicles[index];
            return GestureDetector(
              onTap: () {
                context.push(CurrentVehiclePage.routePath, extra: vehicle);
              },
              child: VehicleCard(
                vehicle: vehicle,
                isLarge: true,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
