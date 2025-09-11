import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmakerapp/interface_adapters/providers/AppStateProvider.dart';

import '../../../interface_adapters/providers/createTravelProvider.dart';
import '../../../usecase/repositories/person_repository_database.dart';
import '../../../usecase/repositories/stop_repository.dart';
import '../../../usecase/repositories/travel_repository.dart';
import '../../../usecase/repositories/user_repository.dart';
import '../modules/travelForm/travelForm.dart';
class CreateTravelScreen extends StatelessWidget {
  const CreateTravelScreen({super.key,});

  static const routeName = '/CreateTravelScreen';


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => CreateTravelProvider(
        context.read<UserRepository>(),
        context.read<TravelRepository>(),
        context.read<StopRepository>(),
        context.read<PersonRepository>(),
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                "Criando uma viagem!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
            ),
            SliverToBoxAdapter(
              child: TravelForm(),
            )
          ],
        ),
      ),
    );
  }
}
